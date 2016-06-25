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

public class Haste : GLib.Object, Budgie.Plugin
{
    public Budgie.Applet get_panel_widget(string uuid)
    {
        return new HasteApplet.HasteApplet(uuid);
    }
}

[GtkTemplate (ui = "/com/github/cybre/haste-applet/settings.ui")]
public class HasteAppletSettings : Gtk.Grid
{
    [GtkChild]
    private Gtk.Switch? switch_label;

    [GtkChild]
    private Gtk.Entry? entry_address;

    private Settings? settings;

    public HasteAppletSettings(Settings? settings)
    {
        this.settings = settings;
        settings.bind("enable-label", switch_label, "active", SettingsBindFlags.DEFAULT);
        settings.bind("haste-address", entry_address, "text", SettingsBindFlags.DEFAULT);

        Gtk.Label label_error = new Gtk.Label("");
        label_error.halign = Gtk.Align.CENTER;
        label_error.get_style_context().add_class("dim-label");
        attach(label_error, 1, 2, 2, 1);

        if (!is_the_url_valid(settings.get_string("haste-address"), null)) {
            label_error.label = "URL Invalid";
        }

        settings.changed.connect(() => {
            if (is_the_url_valid(settings.get_string("haste-address"), null)) {
                label_error.label = "";
            } else {
                label_error.label = "URL Invalid";
            }
        });
    }
}

namespace HasteApplet
{
    public class HasteApplet : Budgie.Applet
    {
        Gtk.Popover? popover = null;
        Gtk.EventBox? box = null;
        unowned Budgie.PopoverManager? manager = null;
        protected Settings settings;
        private Gtk.Image img;
        private Gtk.Label label;
        private Gtk.Stack stack;
        public string uuid { public set ; public get; }
        private HistoryView history_view;
        private NewHasteView new_haste_view;
        private Gtk.Clipboard clipboard;

        public override Gtk.Widget? get_settings_ui()
        {
            return new HasteAppletSettings(get_applet_settings(uuid));
        }

        public override bool supports_settings()
        {
            return true;
        }

        public HasteApplet(string uuid)
        {
            Object(uuid: uuid);

            settings_schema = "com.github.cybre.haste-applet";
            settings_prefix = "/com/github/cybre/haste-applet";

            settings = get_applet_settings(uuid);

            settings.changed.connect(on_settings_changed);

            var display = get_display();
            clipboard = Gtk.Clipboard.get_for_display(display, Gdk.SELECTION_CLIPBOARD);

            box = new Gtk.EventBox();
            img = new Gtk.Image.from_icon_name("edit-paste-symbolic", Gtk.IconSize.MENU);
            var layout = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
            layout.pack_start(img, false, false, 3);
            label = new Gtk.Label("Haste");
            label.halign = Gtk.Align.START;
            layout.pack_start(label, true, true, 3);
            box.add(layout);
            add(box);

            popover = new Gtk.Popover(box);
            stack = new Gtk.Stack();

            popover.map.connect(entry_hack);

            new_haste_view = new NewHasteView(stack);
            history_view = new HistoryView(settings, clipboard);

            new_haste_view.history_view = history_view;

            history_view.history_add_button.clicked.connect(() => {
                stack.set_transition_type(Gtk.StackTransitionType.SLIDE_LEFT);
                stack.visible_child_name = "new_haste_view";
                if (!((Gtk.Revealer) new_haste_view.get_child_at(0, 3)).reveal_child) {
                    new_haste_view.get_child_at(0, 3).visible = false;
                }
                new_haste_view.textview.grab_focus();
            });

            stack.add_named(history_view, "history_view");
            stack.add_named(new_haste_view, "new_haste_view");
            stack.homogeneous = false;

            stack.show_all();
            popover.add(stack);

            box.button_press_event.connect((e)=> {
                if (popover.get_visible()) {
                    popover.hide();
                } else {
                    if (e.button == 1) {
                        if (new_haste_view.is_editing) {
                            stack.visible_child_name = "new_haste_view";
                        } else {
                            stack.visible_child_name = "history_view";
                        }
                    } else if (e.button == 3) {
                        stack.visible_child_name = "new_haste_view";
                    } else {
                        return Gdk.EVENT_PROPAGATE;
                    }
                    manager.show_popover(box);
                }
                return Gdk.EVENT_STOP;
            });

            GLib.Variant history_list = settings.get_value("history");
            for (int i=0; i<history_list.n_children(); i++) {
                history_view.update_history(i, true);
            }

            show_all();

            on_settings_changed("enable-label");
            on_settings_changed("enable-history");
            on_settings_changed("haste-address");
        }

        private async void entry_hack()
        {
            if (stack.visible_child_name == "new_haste_view") {
                if (!((Gtk.Revealer) new_haste_view.get_child_at(0, 3)).reveal_child) {
                    new_haste_view.get_child_at(0, 3).visible = false;
                }
                new_haste_view.title_entry.can_focus = false;
                yield sleep_async(1);
                new_haste_view.title_entry.can_focus = true;
            }
        }

        private async void sleep_async(int timeout)
        {
            uint timeout_src = 0;
            timeout_src = GLib.Timeout.add(timeout, sleep_async.callback);
            yield;
            GLib.Source.remove(timeout_src);
        }

        protected void on_settings_changed(string key)
        {
            switch (key)
            {
                case "enable-label":
                    label.set_visible(settings.get_boolean(key));
                    break;
                case "haste-address":
                    string new_url;
                    if (is_the_url_valid(settings.get_string(key), out new_url)) {
                        if (new_haste_view.haste_address_invalid) {
                            new_haste_view.dismiss_error_message();
                            new_haste_view.post_button.sensitive = true;
                            new_haste_view.haste_address_invalid = false;
                        }
                        new_haste_view.haste_address = new_url;
                    } else {
                        if (!new_haste_view.haste_address_invalid) {
                            new_haste_view.show_error_message("Invalid haste-server Address");
                            new_haste_view.post_button.sensitive = false;
                            new_haste_view.haste_address_invalid = true;
                        }
                    }
                    break;
                default:
                    break;
            }
        }

        public override void update_popovers(Budgie.PopoverManager? manager)
        {
            manager.register_popover(box, popover);
            this.manager = manager;
        }
    }
}

bool is_the_url_valid(string url, out string new_url) {
    new_url = "";
    if (url != "") {
        string[] ha_split = url.split("://");
        string[]? ha_split2 = null;
        if (ha_split[1] != null) {
            ha_split2 = ha_split[1].split("/");
        } else {
            ha_split2 = ha_split[0].split("/");
        }
        string[] ha_split3 = ha_split2[0].split(".");
        string[] invalid_characters = {
            "`", "~", "!", "@", "#", "$", "%", "^",
            "&", "*", "(", ")", "-", "_", "=", "+",
            "[", "]", "{", "}", "\\", "|", ";", ":",
            ",", ".", "<", ">", "/", "?"
        };
        foreach (string character in invalid_characters) {
            foreach (string part in ha_split3) {
                if (part.length < 2){
                    return false;
                }
                if (part.contains(character)) {
                    return false;
                }
            }
        }

        if (ha_split3.length >= 2) {
            if (ha_split3[0] != "" && ha_split3[ha_split3.length -1] != "") {
                new_url = ha_split2[0];
                return true;
            }
        }
    }
    return false;
}

[ModuleInit]
public void peas_register_types(TypeModule module)
{
    var objmodule = module as Peas.ObjectModule;
    objmodule.register_extension_type(typeof(Budgie.Plugin), typeof(Haste));
}