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

public class HasteApplet.BudgieHasteApplet : GLib.Object, Budgie.Plugin
{
    public Budgie.Applet get_panel_widget(string uuid)
    {
        return new HasteApplet(uuid);
    }
}

[GtkTemplate (ui = "/com/github/cybre/haste-applet/settings.ui")]
public class HasteApplet.HasteAppletSettings : Gtk.Grid
{
    [GtkChild]
    private Gtk.Switch? switch_label;

    [GtkChild]
    private Gtk.ComboBoxText? combobox_protocol;

    [GtkChild]
    private Gtk.Entry? entry_address;

    private Settings? settings;

    public HasteAppletSettings(Settings? settings)
    {
        this.settings = settings;

        settings.bind("enable-label", switch_label, "active", GLib.SettingsBindFlags.DEFAULT);
        settings.bind("protocol", combobox_protocol, "active_id", GLib.SettingsBindFlags.DEFAULT);
        settings.bind("haste-address", entry_address, "text", GLib.SettingsBindFlags.DEFAULT);
    }
}

public class HasteApplet.HasteApplet : Budgie.Applet
{
    Gtk.Popover? popover = null;
    Gtk.EventBox? applet_box = null;
    unowned Budgie.PopoverManager? manager = null;
    protected Settings settings;
    private Gtk.Label label;
    private Gtk.Stack stack;
    public string uuid { public set ; public get; }
    private HistoryView history_view;
    private NewHasteView new_haste_view;

    public override Gtk.Widget? get_settings_ui() {
        return new HasteAppletSettings(get_applet_settings(uuid));
    }

    public override bool supports_settings() {
        return true;
    }

    public HasteApplet(string uuid)
    {
        Object(uuid: uuid);

        Intl.setlocale(LocaleCategory.ALL, "");
        Intl.bindtextdomain(Config.GETTEXT_PACKAGE, Config.PACKAGE_LOCALEDIR);
        Intl.bind_textdomain_codeset(Config.GETTEXT_PACKAGE, "UTF-8");
        Intl.textdomain(Config.GETTEXT_PACKAGE);

        settings_schema = "com.github.cybre.haste-applet";
        settings_prefix = "/com/github/cybre/haste-applet";

        settings = get_applet_settings(uuid);

        settings.changed.connect(on_settings_changed);

        // Compatibility
        if (!settings.get_boolean("fix-applied")) {
            string haste_address = settings.get_string("haste-address");
            if (haste_address.has_suffix("/")) {
                haste_address = haste_address[0:haste_address.length - 1];
            }
            if (haste_address.has_prefix("http")) {
                string[] haste_split = haste_address.split("://");
                settings.set_string("haste-address", haste_split[1]);
                if (haste_split[1] == "hastebin.com") {
                    settings.set_string("protocol", "https");
                } else {
                    settings.set_string("protocol", haste_split[0]);
                }
            }
            // hastebin has changed the protocol to https
            if (haste_address == "hastebin.com") {
                settings.set_string("protocol", "https");
            }
            settings.set_boolean("fix-applied", true);
        }
        // End Compatibility


        Gdk.Display display = get_display();
        Gtk.Clipboard clipboard = Gtk.Clipboard.get_for_display(display, Gdk.SELECTION_CLIPBOARD);

        Gdk.Screen screen = Gdk.Screen.get_default();
        Gtk.Settings gtk_settings = Gtk.Settings.get_for_screen(screen);
        string gtk_theme_name = gtk_settings.gtk_theme_name.down();

        if (gtk_theme_name.has_prefix("arc")) {
            Gtk.CssProvider provider = new Gtk.CssProvider();
            provider.load_from_resource("/com/github/cybre/haste-applet/style.css");
            Gtk.StyleContext.add_provider_for_screen(screen, provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
        }

        Gtk.Image icon = new Gtk.Image.from_icon_name("edit-paste-symbolic", Gtk.IconSize.MENU);
        label = new Gtk.Label(_("Hastes"));
        label.set_halign(Gtk.Align.START);
        Gtk.Box layout = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
        layout.pack_start(icon, false, false, 3);
        layout.pack_start(label, true, true, 3);
        applet_box = new Gtk.EventBox();
        applet_box.add(layout);

        stack = new Gtk.Stack();
        stack.set_transition_type(Gtk.StackTransitionType.SLIDE_LEFT_RIGHT);

        new_haste_view = new NewHasteView(stack);
        history_view = new HistoryView(settings, clipboard);

        new_haste_view.history_view = history_view;

        history_view.history_add_button.clicked.connect(() => {
            stack.set_visible_child_name("new_haste_view");
            new_haste_view.textview.grab_focus();
        });

        stack.add_named(history_view, "history_view");
        stack.add_named(new_haste_view, "new_haste_view");
        stack.set_homogeneous(false);
        stack.show_all();

        popover = new Gtk.Popover(applet_box);
        popover.get_style_context().add_class("haste-applet");
        popover.add(stack);
        popover.map.connect(entry_hack);

        applet_box.button_press_event.connect((e)=> {
            if (popover.get_visible()) {
                popover.hide();
            } else {
                string child_name = "";
                if (e.button == 1) {
                    if (new_haste_view.is_editing) {
                        child_name = "new_haste_view";
                    } else {
                        child_name = "history_view";
                    }
                } else if (e.button == 3) {
                    child_name = "new_haste_view";
                } else {
                    return Gdk.EVENT_PROPAGATE;
                }
                stack.set_visible_child_name(child_name);
                manager.show_popover(applet_box);
            }
            return Gdk.EVENT_STOP;
        });

        GLib.Variant history_list = settings.get_value("history");
        for (int i=0; i<history_list.n_children(); i++) {
            history_view.update_history(i, true);
        }

        add(applet_box);
        show_all();

        on_settings_changed("enable-label");
        on_settings_changed("haste-address");
        on_settings_changed("protocol");
    }

    private async void entry_hack()
    {
        if (stack.visible_child_name == "new_haste_view") {
            new_haste_view.title_entry.set_can_focus(false);
            GLib.Timeout.add(1, () => {
                new_haste_view.title_entry.set_can_focus(true);
                return false;
            });
        }
    }

    protected void on_settings_changed(string key)
    {
        switch (key) {
            case "enable-label":
                label.set_visible(settings.get_boolean(key));
                break;
            case "haste-address":
                new_haste_view.haste_address = settings.get_string(key);
                break;
            case "protocol":
                new_haste_view.protocol = settings.get_string(key);
                break;
            default:
                break;
        }
    }

    public override void update_popovers(Budgie.PopoverManager? manager)
    {
        manager.register_popover(applet_box, popover);
        this.manager = manager;
    }
}

[ModuleInit]
public void peas_register_types(TypeModule module)
{
    var objmodule = module as Peas.ObjectModule;
    objmodule.register_extension_type(typeof(Budgie.Plugin), typeof(HasteApplet.BudgieHasteApplet));
}