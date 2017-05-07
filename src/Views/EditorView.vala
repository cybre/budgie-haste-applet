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

[GtkTemplate (ui = "/com/github/cybre/budgie-haste-applet/ui/editor_view.ui")]
private class EditorView : Gtk.Box
{
    [GtkChild]
    private Gtk.Entry? title_entry;

    [GtkChild]
    private Gtk.Box? haste_box;

    [GtkChild]
    private Gtk.CheckButton? upload_checkbutton;

    [GtkChild]
    private Gtk.Button? save_button;

    [GtkChild]
    private Gtk.TextBuffer? textbuffer;

    private static EditorView? _instance = null;
    public static bool new_paste_in_progress = false;

    private HistoryItem? current_item;

    public EditorView() {
        _instance = this;

        GLib.Settings settings = BackendUtil.settings_manager.get_settings();

        settings.bind("automatic-upload", upload_checkbutton, "active", GLib.SettingsBindFlags.DEFAULT);
    }

    [GtkCallback]
    private void go_back() {
        title_entry.set_text("");
        textbuffer.set_text("");
        MainStack.set_page("history_view");
    }

    [GtkCallback]
    private void clear_title() {
        title_entry.set_text("");
    }

    [GtkCallback]
    private void buffer_changed() {
        new_paste_in_progress = (textbuffer.text != "" || title_entry.text != "");
        haste_box.set_sensitive(textbuffer.text != "");
        save_button.set_sensitive(textbuffer.text != "");
    }

    [GtkCallback]
    private void haste_it()
    {
        debug("save_paste()");
        GLib.DateTime datetime = new GLib.DateTime.now_local();
        int64 timestamp = datetime.to_unix();
        HistoryView.get_instance().add_to_history.begin(timestamp, title_entry.text, textbuffer.text);
        MainStack.set_page("history_view");
        title_entry.set_text("");
        textbuffer.set_text("");
    }

    [GtkCallback]
    private void save_it()
    {
        MainStack.set_page("history_view");
        current_item.item_title = title_entry.text;
        current_item.item_data = textbuffer.text;
        current_item.apply_changes();
        title_entry.set_text("");
        textbuffer.set_text("");
    }

    public void populate(HistoryItem item)
    {
        this.current_item = item;
        show_save_button(true);
        title_entry.set_text(item.item_title);
        textbuffer.set_text(item.item_data);
    }

    public void show_save_button(bool state)
    {
        haste_box.set_no_show_all(state);
        haste_box.set_visible(!state);
        save_button.set_no_show_all(!state);
        save_button.set_visible(state);
        if (!state) {
            current_item = null;
        }
    }

    public static unowned EditorView? get_instance() {
        return _instance;
    }
}

} // End namespace