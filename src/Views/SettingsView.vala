/*
 * This file is part of budgie-screenshot-applet
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

namespace HasteApplet.Views
{

[GtkTemplate (ui = "/com/github/cybre/budgie-haste-applet/ui/settings_view.ui")]
private class SettingsView : Gtk.Box
{
    [GtkChild]
    private Gtk.ComboBox? upload_provider_combobox;

    [GtkChild]
    private Gtk.Revealer? hastebin_server_revealer;

    [GtkChild]
    private Gtk.Entry? hastebin_server_entry;

    [GtkChild]
    private Gtk.Revealer? github_token_revealer;

    [GtkChild]
    private Gtk.Entry? github_token_entry;

    [GtkChild]
    private Gtk.Switch? automatic_copy_switch;

    public SettingsView()
    {
        upload_provider_combobox.set_model(get_provider_list());
        Gtk.CellRendererText upload_provider_renderer = new Gtk.CellRendererText();
        upload_provider_renderer.max_width_chars = 13;
        upload_provider_renderer.ellipsize = Pango.EllipsizeMode.MIDDLE;
        upload_provider_combobox.pack_start(upload_provider_renderer, true);
        upload_provider_combobox.add_attribute(upload_provider_renderer, "text", 1);
        upload_provider_combobox.set_id_column(0);

        GLib.Settings settings = BackendUtil.settings_manager.get_settings();
        settings.bind("upload-provider", upload_provider_combobox, "active_id", GLib.SettingsBindFlags.DEFAULT);
        settings.bind("github-token", github_token_entry, "text", GLib.SettingsBindFlags.DEFAULT);
        settings.bind("hastebin-server", hastebin_server_entry, "text", GLib.SettingsBindFlags.DEFAULT);
        settings.bind("automatic-copy", automatic_copy_switch, "active", GLib.SettingsBindFlags.DEFAULT);

        settings.changed["upload-provider"].connect(() => {
            bool is_hastebin = (settings.get_string("upload-provider") == "hastebin");
            bool is_github = (settings.get_string("upload-provider") == "githubgist");
            hastebin_server_revealer.set_reveal_child(is_hastebin);
            github_token_revealer.set_reveal_child(is_github);
        });

        bool is_hastebin = (settings.get_string("upload-provider") == "hastebin");
        bool is_github = (settings.get_string("upload-provider") == "githubgist");
        hastebin_server_revealer.set_reveal_child(is_hastebin);
        github_token_revealer.set_reveal_child(is_github);
    }

    [GtkCallback]
    private void go_back() {
        MainStack.set_page("history_view");
    }

    [GtkCallback]
    private void restore_settings() {
        BackendUtil.settings_manager.reset_all();
    }

    private Gtk.ListStore get_provider_list()
    {
        Gtk.ListStore providers = new Gtk.ListStore(2, typeof(string), typeof(string));
        Gtk.TreeIter? iter = null;

        BackendUtil.uploader.get_providers().foreach((key, val) => {
            providers.append(out iter);
            providers.set(iter, 0, key, 1, val.get_name());
        });

        return providers;
    }
}

} // End namespace