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

namespace HasteApplet.Backend.Providers
{

private class Hastebin : IProvider
{
    private Soup.SessionAsync session;

    public Hastebin()
    {
        session = new Soup.SessionAsync();
        session.ssl_strict = false;
        // Add a logger:
        Soup.Logger logger = new Soup.Logger(Soup.LoggerLogLevel.MINIMAL, -1);
        session.add_feature(logger);
    }

    public override async bool upload_data(string title, string data, out string? link)
    {
        link = null;

        string hastebin_server = BackendUtil.settings_manager.hastebin_server;
        if (hastebin_server.has_suffix("/")) {
            hastebin_server = hastebin_server.slice(0, hastebin_server.len() - 1);
        }

        string url = @"$hastebin_server/documents";

        Soup.Message message = new Soup.Message("POST", url);
        message.set_request("application/x-www-form-urlencoded", Soup.MemoryUse.COPY, data.data);
        message.set_flags(Soup.MessageFlags.NO_REDIRECT);

        string? payload = null;
        session.send_message(message);

        payload = (string)message.response_body.data;

        if (payload == null) {
            return false;
        }

        Json.Parser parser = new Json.Parser();
        try {
            int64 len = payload.length;
            parser.load_from_data(payload, (ssize_t)len);
        } catch (GLib.Error e) {
            stderr.printf(e.message);
        }

        unowned Json.Object node_obj = parser.get_root().get_object();
        if (node_obj == null) {
            return false;
        }

        string? key = node_obj.get_string_member("key") ?? null;
        if (key == null) {
            warning("ERROR: could not fetch key\n");
            return false;
        }

        link = @"$hastebin_server/$key";

        return true;
    }

    public override string get_name() {
        return "Hastebin";
    }

    public override async void cancel_upload() {
        GLib.Idle.add(() => {
            session.abort();
            return false;
        });
    }
}

}