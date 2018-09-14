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

private class Pastebin : IProvider
{
    private Soup.SessionAsync session;

    public Pastebin()
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

        string url = "https://pastebin.com/api/api_post.php";

        string fields = Soup.Form.encode (
            "api_dev_key", "177ebf23f666f85bd607653ab0c87708",
            "api_option", "paste",
            "api_paste_code", data.data,
            "api_paste_name", title
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

        if (!payload.has_prefix("http")) {
            return false;
        }

        link = payload;

        return true;
    }

    public override string get_name() {
        return "Pastebin";
    }

    public override async void cancel_upload() {
        GLib.Idle.add(() => {
            session.abort();
            return false;
        });
    }
}

}