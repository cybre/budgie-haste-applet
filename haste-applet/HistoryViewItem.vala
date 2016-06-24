/*
 * This file is part of haste-applet
 * 
 * Copyright (C) 2016 Stefan Ric <stfric369@gmail.com>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 */

namespace HasteApplet
{
    public class HistoryViewItem : Gtk.ListBoxRow
    {
        private Gtk.Box history_view_item_box;
        private Gtk.Box title_box;
        private Gtk.Box title_edit_box;
        private Gtk.Box title_main_box;
        private Gtk.Box url_main_box;
        private Gtk.Label title_label;
        private Gtk.Label url_label;
        private Gtk.Label time_label;
        private Gtk.Button title_edit_button;
        private Gtk.Button title_apply_button;
        private Gtk.Button copy_button;
        private Gtk.Button delete_button;
        private Gtk.EventBox url_event_box;
        private Gtk.Stack title_stack;
        private Gtk.Entry title_entry;
        private GLib.Settings gnome_settings;
        private GLib.DateTime time;
        private GLib.Variant history_list;
        private GLib.Variant history_entry;
        private string title;
        private string url;
        private int64 timestamp;
        public Gtk.Revealer revealer;

        public HistoryViewItem(int n, Gtk.Clipboard clipboard,
            GLib.Settings settings, HistoryView history_view)
        {
            selectable = false;
            can_focus = false;
            activatable = false;

            history_list = settings.get_value("history");
            history_entry = history_list.get_child_value(n);
            history_entry.get("(xss)", out timestamp, out title, out url);

            time = new GLib.DateTime.from_unix_local(timestamp);

            title_label = new Gtk.Label("<b>%s</b>".printf(title));
            title_label.use_markup = true;
            title_label.halign = Gtk.Align.START;
            title_label.max_width_chars = 23;
            title_label.ellipsize = Pango.EllipsizeMode.END;

            title_edit_button = new Gtk.Button.from_icon_name(
                "accessories-text-editor-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            title_edit_button.relief = Gtk.ReliefStyle.NONE;
            title_edit_button.can_focus = false;
            title_edit_button.tooltip_text = "Edit Title";

            title_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
            title_box.pack_start(title_label, true, true, 0);
            title_box.pack_end(title_edit_button, false, false, 0);

            title_entry = new Gtk.Entry();
            title_entry.placeholder_text = "New Title";
            title_entry.margin_end = 10;

            title_entry.set_icon_from_icon_name(
                Gtk.EntryIconPosition.SECONDARY, "edit-clear-symbolic");
            title_entry.set_icon_tooltip_text(Gtk.EntryIconPosition.SECONDARY, "Clear");
            title_entry.icon_press.connect(() => {
                title_entry.text = "";
            });

            title_apply_button = new Gtk.Button.from_icon_name(
                "emblem-ok-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            title_apply_button.relief = Gtk.ReliefStyle.NONE;
            title_apply_button.can_focus = false;
            title_apply_button.tooltip_text = "Apply Changes";

            title_edit_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
            title_edit_box.pack_start(title_entry, true, true, 0);
            title_edit_box.pack_end(title_apply_button, false, false, 0);

            title_stack = new Gtk.Stack();
            title_stack.set_transition_type(Gtk.StackTransitionType.CROSSFADE);
            title_stack.add_named(title_box, "title_box");
            title_stack.add_named(title_edit_box, "title_edit_box");

            copy_button = new Gtk.Button.from_icon_name(
                "edit-copy-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            copy_button.relief = Gtk.ReliefStyle.NONE;
            copy_button.can_focus = false;
            copy_button.tooltip_text = "Copy Haste URL";

            delete_button = new Gtk.Button.from_icon_name(
                "list-remove-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            delete_button.relief = Gtk.ReliefStyle.NONE;
            delete_button.can_focus = false;
            delete_button.tooltip_text = "Delete Haste";
            
            title_main_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
            title_main_box.pack_start(title_stack, true, true, 0);
            title_main_box.pack_end(delete_button, false, false, 0);
            title_main_box.pack_end(copy_button, false, false, 0);

            url_label = new Gtk.Label(url);
            url_label.halign = Gtk.Align.START;
            url_label.get_style_context().add_class("dim-label");
            url_label.max_width_chars = 23;
            url_label.ellipsize = Pango.EllipsizeMode.MIDDLE;

            url_event_box = new Gtk.EventBox();
            url_event_box.add(url_label);
            url_event_box.button_press_event.connect(() => {
                try {
                    GLib.Process.spawn_command_line_async("xdg-open http://%s".printf(url));
                } catch (GLib.SpawnError e) {
                    stderr.printf(e.message);
                }
                return true;
            });

            gnome_settings = new GLib.Settings("org.gnome.desktop.interface");
            string time_format = gnome_settings.get_string("clock-format");

            string? time_text = null;

            if (time_format == "24h") {
                time_text = time.format("%H:%M");
            } else if (time_format == "12h") {
                time_text = time.format("%l:%M %p");
            }

            time_label = new Gtk.Label(time_text);
            time_label.tooltip_text = time.format("%d %B %Y");
            time_label.valign = Gtk.Align.CENTER;
            time_label.get_style_context().add_class("dim-label");

            gnome_settings.changed.connect((key) => {
                if (key == "clock-format") {
                    time_format = gnome_settings.get_string("clock-format");
                    if (time_format == "24h") {
                        time_text = time.format("%H:%M");
                    } else if (time_format == "12h") {
                        time_text = time.format("%l:%M %p");
                    }
                    time_label.label = time_text;
                }
            });

            url_main_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
            url_main_box.pack_start(url_event_box, true, true, 0);
            url_main_box.pack_end(time_label, false, false, 0);

            title_edit_button.clicked.connect(() => {
                title_entry.text = title;
                title_stack.set_visible_child_name("title_edit_box");
                title_entry.grab_focus();
            });

            title_apply_button.clicked.connect(() => {
                if (title_entry.text != title) {
                    apply_changes(settings);
                    title_stack.set_visible_child_name("title_box");
                } else {
                    title_stack.set_visible_child_name("title_box");
                }
            });

            title_entry.activate.connect(() => {
                apply_changes(settings);
                title_stack.set_visible_child_name("title_box");
            });

            title_entry.key_press_event.connect((event) => {
                if (event.keyval == Gdk.Key.Escape) {
                    title_stack.set_visible_child_name("title_box");
                    return true;
                }
                return false;
            });

            copy_button.clicked.connect(() => {
                clipboard.set_text("http://%s".printf(url), -1);
            });

            delete_button.clicked.connect(() => {
                delete_item(settings, history_view);
                history_view.update_child_count();
            });

            history_view_item_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
            history_view_item_box.margin_top = 5;
            history_view_item_box.margin_bottom = 5;
            history_view_item_box.margin_start = 10;
            history_view_item_box.margin_end = 10;
            history_view_item_box.pack_start(title_main_box, true, true, 0);
            history_view_item_box.pack_start(url_main_box, true, true, 0);

            revealer = new Gtk.Revealer();
            revealer.transition_type = Gtk.RevealerTransitionType.NONE;
            revealer.transition_duration = 500;
            revealer.add(history_view_item_box);

            add(revealer);
            show_all();
        }

        private void delete_item(GLib.Settings settings, HistoryView history_view)
        {
            int index = get_index();

            if (index == 0) {
                Gtk.Widget row_after = history_view.history_listbox.get_row_at_index(index + 1);
                if (row_after != null) row_after.destroy();
            } else {
                Gtk.Widget row_before = history_view.history_listbox.get_row_at_index(index - 1);
                if (row_before != null) row_before.destroy();
            }

            if (history_view.history_listbox.get_children().length() != 1) {
                revealer.transition_type = Gtk.RevealerTransitionType.SLIDE_DOWN;
                revealer.transition_duration = 150;
                revealer.reveal_child = false;
                GLib.Timeout.add(150, () => {
                    destroy();
                    return true;
                });
            } else {
                destroy();
            }

            history_list = settings.get_value("history");
            GLib.Variant[]? history_l = null;
            GLib.Variant? history_entry_curr = null;

            if (history_list.n_children() == 1) {
                settings.reset("history");
            } else {
                for (int i=0; i<history_list.n_children(); i++) {
                    history_entry_curr = history_list.get_child_value(i);
                    string? entry_url = null;
                    history_entry_curr.get("(xss)", null, null, out entry_url);
                    if (entry_url != url) {
                        history_l += history_entry_curr;
                    }
                }

                GLib.Variant history_entry_array = new GLib.Variant.array(null, history_l);
                settings.set_value("history", history_entry_array);
            }
        }

        private void apply_changes(GLib.Settings settings)
        {
            if (title_entry.text == "") {
                title = "<b>Untitled</b>";
            } else {
                title = "<b>%s</b>".printf(title_entry.text);
            }

            title_label.set_text(title);
            title_label.use_markup = true;
            title = title_label.get_text();

            history_list = settings.get_value("history");
            GLib.Variant[]? history_variant_list = null;
            GLib.Variant? history_entry_curr = null;
            GLib.Variant? history_entry_new = null;

            for (int i=0; i<history_list.n_children(); i++) {
                history_entry_curr = history_list.get_child_value(i);
                string? entry_url = null;
                history_entry_curr.get("(xss)", null, null, out entry_url);
                if (entry_url == url) {
                    GLib.Variant entry_timestamp_variant = new GLib.Variant.int64(timestamp);
                    GLib.Variant entry_title_variant = new GLib.Variant.string(title);
                    GLib.Variant entry_url_variant = new GLib.Variant.string(url);
                    history_entry_new = new GLib.Variant.tuple(
                        {entry_timestamp_variant, entry_title_variant, entry_url_variant});
                    history_variant_list += history_entry_new;
                } else {
                    history_variant_list += history_entry_curr;
                }
            }

            GLib.Variant history_entry_array = new GLib.Variant.array(null, history_variant_list);
            settings.set_value("history", history_entry_array);
        }
    }
}