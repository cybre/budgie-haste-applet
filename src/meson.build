gnome = import('gnome')

LOCALE_DIR = join_paths(get_option('prefix'), get_option('localedir'))

data_dir = join_paths(meson.source_root(), 'data')
vapi_dir = join_paths(meson.source_root(), 'vapi')

gresource_file = join_paths(data_dir, 'com.github.cybre.budgie-haste-applet.gresource.xml')
res = gnome.compile_resources('bha-resources', gresource_file, source_dir: data_dir)

conf_data = configuration_data()
conf_data.set('PACKAGE_NAME', meson.project_name())
conf_data.set('LOCALE_DIR', LOCALE_DIR)
configure_file(input: 'config.h.in', output: 'config.h', configuration: conf_data)

bha_sources = ['HasteApplet.vala',
               'Views/EditorView.vala',
               'Views/HistoryView.vala',
               'Views/SettingsView.vala',
               'Widgets/AutomaticScrollBox.vala',
               'Widgets/HistoryItem.vala',
               'Widgets/IndicatorWindow.vala',
               'Widgets/MainStack.vala',
               'Backend/Providers/IProvider.vala',
               'Backend/Providers/GitHubGist.vala',
               'Backend/Providers/GPaste.vala',
               'Backend/Providers/Hastebin.vala',
               'Backend/Providers/Pastebin.vala',
               'Backend/BackendUtil.vala',
               'Backend/SettingsManager.vala',
               'Backend/Uploader.vala',
               res]

bha_deps = [dependency('gtk+-3.0', version: '>=3.18'),
            dependency('budgie-1.0', version: '>=2'),
            dependency('json-glib-1.0'),
            dependency('libsoup-2.4')]

bha_vala_args = ['--pkg=config',
                 '--vapidir=' + vapi_dir,
                 '--gresources=' + gresource_file,
                 '--target-glib=2.38',
                 '--enable-deprecated']

bha_c_args = ['-include', 'config.h']

shared_library('hasteapplet', bha_sources,
               dependencies: bha_deps,
               vala_args: bha_vala_args,
               c_args: bha_c_args,
               install: true,
               install_dir: LIB_INSTALL_DIR)