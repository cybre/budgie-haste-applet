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

private class GPaste : IProvider
{
    private Soup.SessionAsync session;

    public GPaste()
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

        string url = "https://paste.gnome.org/api/json/create";

        // One year
        int expire = (24 * 60 * 60) * 365;

        string fields = Soup.form_encode (
            "data", data.data,
            "title", title,
            "language", "text",
            "expire", expire.to_string(),
            "private", "true"
        );

        Soup.Message message = new Soup.Message("POST", url);
        message.set_request("application/x-www-form-urlencoded", Soup.MemoryUse.COPY, fields.data);
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

        node_obj = node_obj.get_object_member("result");
        if (node_obj == null) {
            return false;
        }

        string? key = node_obj.get_string_member("id") ?? null;
        if (key == null) {
            warning("ERROR: could not fetch key\n");
            return false;
        }

        string? hash = node_obj.get_string_member("hash") ?? null;
        if (key == null) {
            warning("ERROR: could not fetch hash\n");
            return false;
        }

        link = @"https://paste.gnome.org/$key/$hash";

        return true;
    }

    public override string get_name() {
        return "GNOME Paste";
    }

    public override async void cancel_upload() {
        GLib.Idle.add(() => {
            session.abort();
            return false;
        });
    }
}

}