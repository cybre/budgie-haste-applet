/*
 * This file is part of screenshot-applet
 *
 * Copyright (C) 2016 Stefan Ric <stfric369@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 */

using HasteApplet.Backend;

namespace HasteApplet.Widgets
{

[GtkTemplate (ui = "/com/github/cybre/budgie-haste-applet/ui/history_item.ui")]
public class HistoryItem : Gtk.Box
{
    [GtkChild]
    private Gtk.Revealer? main_revealer;

    [GtkChild]
    private Gtk.Stack? main_stack;

    [GtkChild]
    private Gtk.Label? title_label;

    [GtkChild]
    private Gtk.Stack? copy_stack;

    [GtkChild]
    private Gtk.Label? uri_label;

    [GtkChild]
    private Gtk.Label? time_label;

    [GtkChild]
    private Gtk.Box? action_area;

    [GtkChild]
    public Gtk.Separator? separator;

    private string _item_title;
    private string _item_data;
    private string _item_uri;

    private int64 item_timestamp;

    public string item_title {
        get {
            return _item_title;
        }
        set {
            _item_title = value;
        }
    }

    public string item_data {
        get {
            return _item_data;
        }
        set {
            if (_item_data == value) {
                return;
            }
            _item_data = value;
            if (item_uri.has_prefix("http")) {
                upload_item.begin();
            }
        }
    }

    public string item_uri {
        get {
            return _item_uri;
        }
        set {
            _item_uri = value;
            apply_changes();
        }
    }

    private unowned GLib.Settings settings;
    private ulong map_signal;

    public signal void deletion(bool only_item);
    public signal void upload_started();
    public signal void update_progress(int64 size, int64 progress);
    public signal void upload_finished(string? new_uri, bool status);

    public HistoryItem(int64 timestamp, string title, string data, string uri, bool startup = false)
    {
        this.item_timestamp = timestamp;
        this._item_title = title;
        this._item_data = data;
        this._item_uri = (uri != "") ? uri : _("Local");

        settings = BackendUtil.settings_manager.get_settings();

        title_label.set_text(@"<b>$item_title</b>");
        title_label.set_use_markup(true);

        string uri_string = item_uri;

        if (item_uri.has_prefix("http")) {
            uri_string = uri_string.split("://")[1];
            copy_stack.set_visible_child_name("copy");
        }

        uri_label.set_text(uri_string);

        GLib.DateTime time = new GLib.DateTime.from_unix_local(timestamp);
        GLib.Settings gnome_settings = new GLib.Settings("org.gnome.desktop.interface");
        string time_format = gnome_settings.get_string("clock-format");
        string time_text = (time_format == "24h") ? time.format("%H:%M") : time.format("%l:%M %p");

        time_label.set_text(time_text);
        time_label.set_tooltip_text(time.format("%d %B %Y"));

        if (!startup) {
            GLib.Timeout.add(100, () => {
                main_revealer.set_reveal_child(true);
                if (BackendUtil.settings_manager.automatic_upload) {
                    upload_item.begin();
                } else {
                    this.get_style_context().add_class("new-item");
                }
                return false;
            });
            if (!BackendUtil.settings_manager.automatic_upload) {
                map_signal = Widgets.IndicatorWindow.get_instance().map.connect(() => {
                    GLib.Timeout.add(300, () => {
                        this.get_style_context().remove_class("new-item");
                        this.get_style_context().add_class("new-item-disappear");
                        disconnect_map();
                        return false;
                    });
                });
            }
        } else {
            main_revealer.set_reveal_child(true);
        }

        this.upload_started.connect(() => {
            main_stack.set_visible_child_name("uploading");
        });

        this.upload_finished.connect((new_uri, status) => {
            if (BackendUtil.uploader.is_cancelled()) {
                main_stack.set_visible_child_name("normal");
                return;
            }
            if (status) {
                item_uri = new_uri;
                string uri_text = item_uri.split("://")[1];
                uri_label.set_text(uri_text);
                copy_stack.set_visible_child_name("copy");
                main_stack.set_visible_child_name("normal");
                if (BackendUtil.settings_manager.automatic_copy) {
                    copy_uri();
                }
            } else {
                GLib.Timeout.add(500, () => {
                    main_stack.set_visible_child_name("error");
                    return false;
                });
            }

        });

        main_revealer.enter_notify_event.connect(() => {
            action_area.get_style_context().add_class("shown");
            return true;
        });

        main_revealer.leave_notify_event.connect(() => {
            action_area.get_style_context().remove_class("shown");
            return true;
        });

        this.show_all();
    }

    private void disconnect_map() {
        IndicatorWindow.get_instance().disconnect(map_signal);
        GLib.Timeout.add(1300, () => {
            this.get_style_context().remove_class("new-item-disappear");
            return false;
        });
    }

    [GtkCallback]
    private void edit_paste()
    {
        Views.EditorView.get_instance().populate(this);
        MainStack.set_page("editor_view");
    }

    [GtkCallback]
    private void copy_uri()
    {
        copy_stack.set_visible_child_name("ok");
        Views.HistoryView.copy_uri(item_uri);
        GLib.Timeout.add(500, () => {
            copy_stack.set_visible_child_name("copy");
            return false;
        });
    }

    [GtkCallback]
    private async void upload_item()
    {
        BackendUtil.uploader.add_to_queue(this);

        if (BackendUtil.uploader.is_upload_in_progress()) {
            main_stack.set_visible_child_name("waiting");
        } else {
            BackendUtil.uploader.start_upload.begin();
        }
    }

    [GtkCallback]
    private async void cancel_upload() {
        GLib.Idle.add(() => {
            main_stack.set_visible_child_name("normal");
            return false;
        });
        BackendUtil.uploader.cancel_upload.begin();
    }

    [GtkCallback]
    public void delete_item()
    {
        GLib.Variant history_list = settings.get_value("history");
        GLib.Variant[]? history_l = null;
        GLib.Variant? history_entry_curr = null;

        if (history_list.n_children() == 1) {
            // There's only one item, just reset the key.
            settings.reset("history");
            Gtk.Widget? parent = this.get_parent();
            if (parent != null) {
                deletion(true);
                parent.destroy();
            }
            return;
        } else {
            for (int i=0; i<history_list.n_children(); i++) {
                history_entry_curr = history_list.get_child_value(i);
                int64 timestamp;
                history_entry_curr.get("(xsss)", out timestamp, null, null, null);
                if (timestamp != item_timestamp) {
                    history_l += history_entry_curr;
                }
            }

            GLib.Variant history_entry_array = new GLib.Variant.array(null, history_l);
            settings.set_value("history", history_entry_array);
        }

        main_revealer.set_transition_type(Gtk.RevealerTransitionType.SLIDE_DOWN);
        main_revealer.set_transition_duration(200);

        /* The revealer close animation never gets triggered for
         * the first item in the list for some reason
         * so this will destroy the parent without the close animation.
         * Might be a GTK+ bug.
         */
        main_revealer.notify["child-revealed"].connect_after(() => {
            Gtk.Widget? parent = this.get_parent();
            if (parent != null) {
                deletion(false);
                parent.destroy();
            }
        });

        main_stack.set_transition_duration(350);
        main_stack.set_visible_child_full("deleting", Gtk.StackTransitionType.SLIDE_RIGHT);
        main_revealer.set_reveal_child(false);
    }

    [GtkCallback]
    private bool open_uri()
    {
        if (item_uri == "") {
            return Gdk.EVENT_PROPAGATE;
        }

        if (!item_uri.has_prefix("http")) {
            return Gdk.EVENT_PROPAGATE;
        }

        try {
            Gtk.show_uri(Gdk.Screen.get_default(), item_uri, Gdk.CURRENT_TIME);
        } catch (GLib.Error e) {
            warning(e.message);
        }

        return Gdk.EVENT_STOP;
    }

    [GtkCallback]
    private void cancel_after_fail() {
        main_stack.set_visible_child_name("normal");
    }

    [GtkCallback]
    private void cancel_queued_upload() {
        main_stack.set_visible_child_name("normal");
        BackendUtil.uploader.remove_from_queue(this);
    }

    public void apply_changes()
    {
        item_title = (item_title == "") ? _("Untitled") : item_title.strip();
        title_label.set_text(@"<b>$item_title</b>");
        title_label.set_use_markup(true);

        GLib.Variant history_list = settings.get_value("history");
        GLib.Variant[]? history_variant_list = null;
        GLib.Variant? history_entry_curr = null;
        GLib.Variant? history_entry_new = null;

        for (int i=0; i<history_list.n_children(); i++) {
            history_entry_curr = history_list.get_child_value(i);
            int64 timestamp;
            history_entry_curr.get("(xsss)", out timestamp, null, null, null);
            if (timestamp == item_timestamp) {
                GLib.Variant[] entry_variant_array = {
                    new GLib.Variant.int64(item_timestamp),
                    new GLib.Variant.string(item_title),
                    new GLib.Variant.string(item_data),
                    new GLib.Variant.string(item_uri)
                };
                history_entry_new = new GLib.Variant.tuple(entry_variant_array);
                history_variant_list += history_entry_new;
            } else {
                history_variant_list += history_entry_curr;
            }
        }

        GLib.Variant history_entry_array = new GLib.Variant.array(null, history_variant_list);
        settings.set_value("history", history_entry_array);
    }
}

} // End namespace
