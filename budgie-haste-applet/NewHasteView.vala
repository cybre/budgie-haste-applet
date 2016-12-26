/*
 * This file is part of haste-applet
 *
 * Copyright (C) 2016 Stefan Ric <stfric369@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 */

public class HasteApplet.NewHasteView : Gtk.Grid
{
    private Gtk.TextBuffer textbuffer;
    private Gtk.TextIter? start_iter = null;
    private Gtk.TextIter? end_iter = null;
    private Gtk.Revealer error_message_revealer;
    private Gtk.Label error_message_label;
    public Gtk.Entry title_entry;
    public Gtk.TextView textview;
    public Gtk.Button post_button;
    private string? text = null;
    public string haste_address { set; get; default = "https://hastebin.com"; }
    public string protocol { set; get; default = "http"; }
    public bool is_editing { set; get; default = false; }
    public bool haste_address_invalid { set; get; default = false; }
    public HistoryView history_view;

    public NewHasteView(Gtk.Stack stack) {
        Object(row_spacing: 5, border_width: 5);

        Gtk.Button header_back_button = new Gtk.Button.from_icon_name(
            "go-previous-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        header_back_button.set_can_focus(false);
        header_back_button.set_tooltip_text("Back");

        header_back_button.clicked.connect(() => { stack.set_visible_child_name("history_view"); });

        title_entry = new Gtk.Entry();
        title_entry.set_placeholder_text(_("Title (Optional)"));
        title_entry.set_max_length(50);
        title_entry.set_icon_from_icon_name(Gtk.EntryIconPosition.SECONDARY, "edit-clear-symbolic");
        title_entry.set_icon_tooltip_text(Gtk.EntryIconPosition.SECONDARY, "Clear");

        title_entry.icon_press.connect(() => { title_entry.set_text(""); });

        Gtk.Box header_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 5);
        header_box.pack_start(header_back_button, false, false, 0);
        header_box.pack_start(title_entry, true, true, 0);

        textview = new Gtk.TextView();
        textview.set_top_margin(textview.bottom_margin = 10);
        textview.set_left_margin(textview.right_margin = 10);
        textview.set_editable(textview.monospace = true);

        Gtk.ScrolledWindow scroller = new Gtk.ScrolledWindow(null, null);
        scroller.set_shadow_type(Gtk.ShadowType.IN);
        scroller.set_size_request(330, 330);
        scroller.add(textview);

        post_button = new Gtk.Button.with_label(_("Post it!"));
        post_button.set_sensitive(false);
        post_button.set_can_focus(false);
        post_button.get_child().margin = 5;

        textbuffer = textview.get_buffer();

        textbuffer.changed.connect(()=> {
            textbuffer.get_bounds(out start_iter, out end_iter);
            text = textbuffer.get_text(start_iter, end_iter, true);
            if (text == "") {
                post_button.set_sensitive(false);
                if (title_entry.text == "")
                    is_editing = false;
            } else {
                if (!haste_address_invalid) {
                    post_button.set_sensitive(true);
                }
                is_editing = true;
            }
        });

        title_entry.changed.connect(() => {
            if (title_entry.text == "") {
                if (text == "")
                    is_editing = false;
            } else {
                is_editing = true;
            }
        });

        Soup.Session session = new Soup.Session();
        session.ssl_strict = false;

        post_button.clicked.connect(() => { upload_haste(session, stack); });

        error_message_label = new Gtk.Label("");
        error_message_label.get_style_context().add_class("dim-label");
        error_message_revealer = new Gtk.Revealer();
        error_message_revealer.set_no_show_all(true);
        error_message_revealer.hide();
        error_message_revealer.add(error_message_label);

        attach(header_box, 0, 0, 1, 1);
        attach(scroller, 0, 1, 1, 1);
        attach(post_button, 0, 2, 1, 1);
        attach(error_message_revealer, 0, 3, 1, 1);
        show_all();
    }

    private void upload_haste(Soup.Session session, Gtk.Stack stack)
    {
        dismiss_error_message();
        post_button.set_label("Hasting...");
        title_entry.set_sensitive(textview.sensitive = post_button.sensitive = false);

        if (haste_address.has_suffix("/")) {
            haste_address = haste_address[0:haste_address.length - 1];
        }

        string url = "%s://%s/documents".printf(protocol, haste_address);
        Soup.Message message = new Soup.Message("POST", url);

        Soup.MemoryUse buffer = Soup.MemoryUse.COPY;
        textbuffer.get_bounds(out start_iter, out end_iter);
        text = textbuffer.get_text(start_iter, end_iter, true);

        message.set_request("application/x-www-form-urlencoded", buffer, text.data);
        message.set_flags(Soup.MessageFlags.NO_REDIRECT);

        session.queue_message(message, (sess, mess) => {
            string link = "";
            for (int i=8; i < mess.response_body.data.length - 2; i++)
                link += ((char) mess.response_body.data[i]).to_string();

            string? title = null;

            if (title_entry.text == "") {
                title = "Untitled";
            } else {
                title = title_entry.text;
            }

            stdout.printf ("Data: \n%s\n", (string) mess.response_body.data);
            stdout.printf ("Status Code: %u\n", mess.status_code);

            if (link == "" || link.length > 30) {
                show_error_message("Error. Connection to server failed.");
            } else {
                dismiss_error_message();
                link = "%s://%s/%s".printf(protocol, haste_address, link);
                history_view.add_to_history(link, title_entry.text);
                textbuffer.set_text("", 0);
                title_entry.set_text("");
                stack.set_visible_child_name("history_view");
            }

            post_button.set_label("Haste it!");
            title_entry.set_sensitive(true);
            textview.set_sensitive(true);
            post_button.set_sensitive(true);
            post_button.get_child().margin = 5;
        });
        post_button.get_child().margin = 5;
    }

    public void show_error_message(string message)
    {
        error_message_label.set_label(message);
        error_message_label.show();
        error_message_revealer.set_reveal_child(true);
        error_message_revealer.show();
    }

    public void dismiss_error_message()
    {
        error_message_label.set_label("");
        error_message_revealer.hide();
        error_message_revealer.set_reveal_child(false);
    }
}
