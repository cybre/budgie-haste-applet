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

private class GitHubGist : IProvider
{
    private Soup.SessionAsync session;

    public GitHubGist()
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

        string url = "https://api.github.com/gists";
        string github_token = BackendUtil.settings_manager.github_token;

        Json.Generator generator = new Json.Generator();
        Json.Node root = new Json.Node(Json.NodeType.OBJECT);
        var obj = new Json.Object();
        root.set_object(obj);
        generator.set_root(root);

        Json.Object files_obj = new Json.Object();
        Json.Object file_obj = new Json.Object();

        obj.set_boolean_member("public", true);       // "public": true
        obj.set_object_member("files", files_obj);    // "files": {
        files_obj.set_object_member(title, file_obj); //    "Filename": {
        file_obj.set_string_member("content", data);  //      "content": data
                                                      //    }
                                                      // }

        string fields = generator.to_data(null);
        stdout.printf(fields);

        Soup.Message message = new Soup.Message("POST", url);
        message.request_headers.append("User-Agent", "budgie-haste-applet/0.3.0 (https://github.com/cybre/budgie-haste-applet)");
        if (github_token != "") {
            message.request_headers.append("Authorization", @"token $github_token");
        }
        message.request_body.append(Soup.MemoryUse.COPY, fields.data);
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

        string? key = node_obj.get_string_member("html_url") ?? null;
        if (key == null) {
            warning("ERROR: could not fetch html_url\n");
            return false;
        }

        link = key;
        return true;
    }

    public override string get_name() {
        return "GitHub Gist";
    }

    public override async void cancel_upload() {
        GLib.Idle.add(() => {
            session.abort();
            return false;
        });
    }
}

}