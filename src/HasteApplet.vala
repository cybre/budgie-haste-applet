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

using HasteApplet.Backend;
using HasteApplet.Widgets;
using HasteApplet.Views;

namespace HasteApplet
{

public class Plugin : GLib.Object, Budgie.Plugin
{
    public Budgie.Applet get_panel_widget(string uuid) {
        return new Applet(uuid);
    }
}

public class Applet : Budgie.Applet
{
    private Gtk.EventBox event_box;
    private IndicatorWindow? popover = null;
    private GLib.Settings? settings = null;
    private BackendUtil? backend_util = null;
    private unowned Budgie.PopoverManager? manager = null;
    public string uuid { public set; public get; }

    public override bool supports_settings() {
        return false;
    }

    public Applet(string uuid)
    {
        Object(uuid: uuid);

        // Initialise gettext
        GLib.Intl.setlocale(GLib.LocaleCategory.ALL, "");
        GLib.Intl.bindtextdomain(Config.GETTEXT_PACKAGE, Config.PACKAGE_LOCALEDIR);
        GLib.Intl.bind_textdomain_codeset(Config.GETTEXT_PACKAGE, "UTF-8");
        GLib.Intl.textdomain(Config.GETTEXT_PACKAGE);

        settings_schema = "com.github.cybre.budgie-haste-applet";
        settings_prefix = "/com/github/cybre/budgie-haste-applet";
        this.settings = get_applet_settings(uuid);

        backend_util = new BackendUtil(this.settings);

        // Bake in our theme
        Gdk.Screen screen = this.get_display().get_default_screen();
        Gtk.CssProvider provider = new Gtk.CssProvider();
        string gtk_version = @"$(Gtk.get_major_version()).$(Gtk.get_minor_version())";
        string style_file = "/com/github/cybre/budgie-haste-applet/style/style.css";
        provider.load_from_resource(style_file);
        Gtk.StyleContext.add_provider_for_screen(screen, provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

        event_box = new Gtk.EventBox();
        this.add(event_box);

        Gtk.Image icon = new Gtk.Image.from_icon_name("edit-paste-symbolic", Gtk.IconSize.MENU);
        event_box.add(icon);

        popover = new IndicatorWindow(event_box);

        this.show_all();

        event_box.button_press_event.connect((e)=> {
            if (e.button != 1) {
                return Gdk.EVENT_PROPAGATE;
            }

            if (popover.get_visible()) {
                popover.hide();
            } else {
                if (EditorView.new_paste_in_progress) {
                    MainStack.set_page("editor_view");
                } else {
                    MainStack.set_page("history_view", false);
                }
                open_popover();
            }

            return Gdk.EVENT_STOP;
        });
    }

    public override void update_popovers(Budgie.PopoverManager? manager)
    {
        manager.register_popover(event_box, popover);
        this.manager = manager;
    }

    public void open_popover() {
        this.manager.show_popover(event_box);
    }
}

}

[ModuleInit]
public void peas_register_types(TypeModule module)
{
    var objmodule = module as Peas.ObjectModule;
    objmodule.register_extension_type(typeof(Budgie.Plugin), typeof(HasteApplet.Plugin));
}