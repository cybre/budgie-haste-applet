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

public class Haste : GLib.Object, Budgie.Plugin {

    public Budgie.Applet get_panel_widget(string uuid)
    {
        return new HasteApplet(uuid);
    }
}

[GtkTemplate (ui = "/apps/haste-applet/settings/settings.ui")]
public class HasteAppletSettings : Gtk.Grid
{
    [GtkChild]
    private Gtk.Switch? switch_label;

    [GtkChild]
    private Gtk.Entry? entry_address;

    private Settings? settings;

    public HasteAppletSettings(Settings? settings)
    {
        this.settings = settings;
        settings.bind("enable-label", switch_label, "active", SettingsBindFlags.DEFAULT);
        settings.bind("haste-address", entry_address, "text", SettingsBindFlags.DEFAULT);
    }

}

public class HasteApplet : Budgie.Applet
{
    Gtk.Popover? popover = null;
    Gtk.EventBox? box = null;
    unowned Budgie.PopoverManager? manager = null;
    protected Settings settings;
    Gtk.TextIter start_iter;
    Gtk.TextIter end_iter;
    Gtk.Revealer link_revealer;
    Gtk.Box link_box;
    Gtk.LinkButton link_button;
    Gtk.Button copy_button;
    Gtk.Image img;
    Gtk.Label label;
    string text;
    string haste_address;
    public string uuid { public set ; public get; }

    public override Gtk.Widget? get_settings_ui()
    {
        return new HasteAppletSettings(this.get_applet_settings(uuid));
    }

    public override bool supports_settings()
    {
        return true;
    }

    public HasteApplet(string uuid)
    {
        Object(uuid: uuid);

        settings_schema = "apps.haste-applet.settings";
        settings_prefix = "/com/solus-project/budgie-panel/instance/haste-applet";

        settings = this.get_applet_settings(uuid);

        settings.changed.connect(on_settings_changed);

        box = new Gtk.EventBox();
        img = new Gtk.Image.from_icon_name("edit-paste-symbolic", Gtk.IconSize.MENU);
        var layout = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
        layout.pack_start(img, false, false, 3);
        label = new Gtk.Label("Haste");
        label.halign = Gtk.Align.START;
        layout.pack_start(label, true, true, 3);
        box.add(layout);
        add(box);

        popover = new Gtk.Popover(box);

        var scroller = new Gtk.ScrolledWindow(null, null);
        scroller.shadow_type = Gtk.ShadowType.IN;
        scroller.width_request = 320;
        scroller.height_request = 320;

        var textview = new Gtk.TextView();
        textview.left_margin = 10;
        textview.right_margin = 10;
        textview.editable = true;

        scroller.add(textview);

        var post_button = new Gtk.Button.with_label("Haste it!");        

        var grid = new Gtk.Grid();
        grid.row_spacing = 5;
        grid.border_width = 5;

        grid.attach (scroller, 0, 0, 1, 1);
        grid.attach (post_button, 0, 1, 1, 1);

        popover.add(grid);
        grid.show_all();

        post_button.sensitive = false;

        var textbuffer = textview.get_buffer();

        textbuffer.changed.connect(()=> {
            textbuffer.get_bounds(out start_iter, out end_iter);
            text = textbuffer.get_text(start_iter, end_iter, true);
            if (text == "") post_button.sensitive = false;
                else post_button.sensitive = true;
        });

        int br=2;

        var display = this.get_display();
        var clipboard = Gtk.Clipboard.get_for_display(display, Gdk.SELECTION_CLIPBOARD);

        on_settings_changed("haste-address");
        on_settings_changed("enable-label");

        Soup.Session session = new Soup.Session();

        post_button.clicked.connect(()=> {
            string url = "http://%s/documents".printf(haste_address);
            Soup.Message message = new Soup.Message("POST", url);

            Soup.MemoryUse buffer = Soup.MemoryUse.COPY;
            textbuffer.get_bounds(out start_iter, out end_iter);
            text = textbuffer.get_text(start_iter, end_iter, true);
            
            message.set_request("application/x-www-form-urlencoded", buffer, text.data);
            message.set_flags(Soup.MessageFlags.NO_REDIRECT);

            session.queue_message(message, (sess, mess)=> {
                string link = "";
                for (int i=8; i < mess.response_body.data.length - 2; i++)
                    link += ((char) mess.response_body.data[i]).to_string();

                link_revealer = new Gtk.Revealer();
                link_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
                link_button = new Gtk.LinkButton("");
                copy_button = new Gtk.Button();
                img = new Gtk.Image.from_icon_name("edit-copy-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
                copy_button.set_image(img);
                link_box.pack_start(link_button, true, true, 3);
                link_box.pack_start(copy_button, false, false, 3);
                link_revealer.add(link_box);

                grid.attach(link_revealer, 0, br, 1, 1);
                grid.show_all();
                link_revealer.set_reveal_child(true);

                br += 1;

                link = "http://%s/%s".printf(haste_address, link);
                link_button.uri = link;
                link_button.label = link;
                textbuffer.set_text("", 0);

                copy_button.clicked.connect(()=> {
                    clipboard.set_text(link, -1);
                });

                var c = new GLib.Cancellable ();
                destroy_widget(c, grid.get_child_at(0, br - 1), &br);
            });
        });

        box.button_press_event.connect((e)=> {
            if (e.button != 1) {
                return Gdk.EVENT_PROPAGATE;
            }
            if (popover.get_visible()) {
                popover.hide();
            } else {
                this.manager.show_popover(box);
            }
            return Gdk.EVENT_STOP;
        });

        show_all();
    }

    protected void on_settings_changed(string key)
    {
        switch (key)
        {
            case "haste-address":
                haste_address = settings.get_string(key);
                break;
            case "enable-label":
                label.set_visible(settings.get_boolean(key));
                break;
            default:
                break;
        }
    }

    public async void sleep_async(int timeout, GLib.Cancellable? cancellable = null)
    {
        ulong cancel = 0;
        uint timeout_src = 0;
        if (cancellable != null) {
            if (cancellable.is_cancelled()) 
                return;
            cancel = cancellable.cancelled.connect(()=>sleep_async.callback());
        }
        timeout_src = GLib.Timeout.add(timeout, sleep_async.callback);
        yield;
        GLib.Source.remove(timeout_src);

        if (cancel != 0 && ! cancellable.is_cancelled ()) {
            cancellable.disconnect(cancel);
        }
    }

    public async void destroy_widget(Cancellable? c, Gtk.Widget widget, int * br)
    {
        yield sleep_async(7000, c);
        ((Gtk.Revealer) widget).set_reveal_child(false);
        yield sleep_async(2000, c);
        widget.destroy();
        br -= 1;
    }

    public override void update_popovers(Budgie.PopoverManager? manager)
    {
        manager.register_popover(this.box, this.popover);
        this.manager = manager;
    }
}

[ModuleInit]
public void peas_register_types(TypeModule module)
{
    var objmodule = module as Peas.ObjectModule;
    objmodule.register_extension_type(typeof(Budgie.Plugin), typeof(Haste));
}