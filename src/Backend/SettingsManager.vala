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

class SettingsManager : GLib.Object
{
    private GLib.Settings settings;

    public bool automatic_copy {
        get {
            return settings.get_boolean("automatic-copy");
        }
    }

    public bool automatic_upload {
        get {
            return settings.get_boolean("automatic-upload");
        }
    }

    public string github_token {
        owned get {
            return settings.get_string("github-token");
        }
    }

    public string hastebin_server {
        owned get {
            return settings.get_string("hastebin-server");
        }
    }

    public string upload_provider {
        owned get {
            return settings.get_string("upload-provider");
        }
    }

    // All of the keys we use
    private const string[] global_keys = {
        "automatic-copy",
        "automatic-upload",
        "hastebin-server",
        "upload-provider"
    };

    public SettingsManager(GLib.Settings applet_settings) {
        settings = applet_settings;
    }

    public void reset_all() {
        foreach (string key in global_keys) {
            settings.reset(key);
        }
    }

    public unowned GLib.Settings get_settings() {
        return settings;
    }
}

} // End namespace