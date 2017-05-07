/*
 * This file is part of budgie-haste-applet
 *
 * Copyright (C) 2017 Stefan Ric <stfric369@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 */

namespace HasteApplet.Widgets
{

public class MainStack : Gtk.Stack {
    private static MainStack? _instance = null;

    public MainStack()
    {
        this.set_transition_type(Gtk.StackTransitionType.SLIDE_LEFT_RIGHT);
        this.set_transition_duration(300);
        this.set_homogeneous(false);
        this.set_interpolate_size(true);

        MainStack._instance = this;

        Views.HistoryView history_view = new Views.HistoryView();
        this.add_named(history_view, "history_view");
        Views.EditorView editor_view = new Views.EditorView();
        this.add_named(editor_view, "editor_view");
        Views.SettingsView settings_view = new Views.SettingsView();
        this.add_named(settings_view, "settings_view");

        this.show_all();
    }

    public static void set_page(string page, bool animate=true) {
        if (!animate) {
            _instance.set_visible_child_full(page, Gtk.StackTransitionType.NONE);
            return;
        }
        _instance.set_visible_child_name(page);
    }
}

} // End namespace
