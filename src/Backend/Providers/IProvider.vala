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

abstract class IProvider : GLib.Object
{
    public virtual async bool upload_data(string title, string data, out string? link) { link = ""; return false; }
    public virtual string get_name() { return ""; }
    public virtual async void cancel_upload() { }
}

} // End namespace