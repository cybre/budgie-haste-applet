plugindir = $(libdir)/budgie-desktop/plugins

EXTRA_DIST = \
	HasteApplet.plugin

hasteappletdir = $(plugindir)/budgie-haste-applet

hasteapplet_DATA = \
	HasteApplet.plugin

hasteapplet_LTLIBRARIES = \
	libhasteapplet.la

libhasteapplet_la_SOURCES = \
	HasteApplet.vala \
	NewHasteView.vala \
	HistoryView.vala \
	AutomaticScrollBox.vala \
	HistoryViewItem.vala \
	../data/plugin-resources.h \
	../data/plugin-resources.c

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
	--pkg budgie-1.0 \
	--pkg libsoup-2.4 \
	--gresources=${top_srcdir}/data/plugin.gresource.xml \
	--target-glib=2.38
