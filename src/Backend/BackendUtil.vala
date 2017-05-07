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

namespace HasteApplet.Backend
{

class BackendUtil
{
    public static SettingsManager? settings_manager = null;
    public static Uploader? uploader = null;

    public BackendUtil(GLib.Settings settings) {
        settings_manager = new SettingsManager(settings);
        uploader = new Uploader();
    }
}

}