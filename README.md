# haste-applet
A Budgie applet for the haste service.

---

### Dependencies
```
vala
gtk+-3.0
gio-unix-2.0
libpeas-1.0
PeasGtk-1.0
budgie-1.0
libsoup-2.4
```

These can be installed on Solus by running:  
`sudo eopkg it vala libgtk-3-devel glib2-devel libpeas-devel budgie-desktop-devel libsoup-devel`

### Installing
```
./autogen.sh --prefix=/usr
make
sudo make install
```
#### Solus
People using the **unstable** repo on Solus can install haste-applet from the Software Centre or via the command line:
```
sudo eopkg it haste-applet
```
The package will be available in the **stable** repo as soon as the next repo sync occurs.

#### Arch Linux
The package can be installed on Arch using
```
yaourt -S haste-applet
```

---

### Screenshot
![Screenshot](screenshot.png)
