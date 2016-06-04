plugindir = $(libdir)/budgie-desktop/plugins

hasteappletdir = $(plugindir)/haste-applet

plugin_resources = $(shell glib-compile-resources --sourcedir=$(top_srcdir)/haste-applet --generate-dependencies $(top_srcdir)/haste-applet/plugin.gresource.xml)

# resources
plugin-resources.h: $(top_srcdir)/haste-applet/plugin.gresource.xml $(plugin_resources)
	glib-compile-resources --target=$@ --sourcedir=$(top_srcdir)/haste-applet --generate-header --c-name haste_applet $<

plugin-resources.c: $(top_srcdir)/haste-applet/plugin.gresource.xml $(plugin_resources)
	glib-compile-resources --target=$@ --sourcedir=$(top_srcdir)/haste-applet --generate-source --c-name haste_applet $<

BUILT_SOURCES = \
	plugin-resources.h \
	plugin-resources.c

CLEANFILES = \
	$(BUILT_SOURCES)

EXTRA_DIST = \
	com.github.cybre.haste-applet.gschema.xml \
	plugin.gresource.xml \
	settings.ui

hasteapplet_DATA = \
	HasteApplet.plugin

hasteapplet_LTLIBRARIES = \
	libhasteapplet.la

libhasteapplet_la_SOURCES = \
	HasteApplet.vala \
	plugin-resources.h \
	plugin-resources.c

libhasteapplet_la_CFLAGS = \
	$(BUDGIE_PLUGIN_CFLAGS) \
	$(SOUP_CFLAGS)

libhasteapplet_la_LIBADD = \
	$(BUDGIE_PLUGIN_LIBS) \
	$(SOUP_LIBS)

libhasteapplet_la_LDFLAGS = \
	-module \
	-avoid-version \
	-shared \
	$(AM_LDFLAGS)

libhasteapplet_la_VALAFLAGS = \
	--pkg gtk+-3.0 \
	--pkg gio-unix-2.0 \
	--pkg libpeas-1.0 \
	--pkg PeasGtk-1.0 \
	--pkg budgie-1.0 \
	--pkg libsoup-2.4 \
	--gresources=${srcdir}/plugin.gresource.xml \
	--target-glib=2.38

gsettings_SCHEMAS = \
	com.github.cybre.haste-applet.gschema.xml
	
@GSETTINGS_RULES@
