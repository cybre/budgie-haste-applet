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

public class IndicatorWindow : Budgie.Popover {
    private static IndicatorWindow? _instance = null;

    public IndicatorWindow(Gtk.Widget? window_parent) {
        GLib.Object(relative_to: window_parent);

        this.set_size_request(320, -1);
        this.get_style_context().add_class("budgie-haste-applet");

        IndicatorWindow._instance = this;

        MainStack main_stack = new MainStack();
        this.add(main_stack);
    }


    public static unowned IndicatorWindow? get_instance() {
        return _instance;
    }
}

} // End namespace