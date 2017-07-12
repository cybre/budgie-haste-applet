datadir = get_option('datadir')

install_data('HasteApplet.plugin',
             install_dir: LIB_INSTALL_DIR)

install_data('com.github.cybre.budgie-haste-applet.gschema.xml',
             install_dir: join_paths(datadir, 'glib-2.0' ,'schemas'))

install_data('com.github.cybre.budgie-haste-applet.appdata.xml',
             install_dir: join_paths(datadir, 'appdata'))

meson.add_install_script('meson_post_install.py')