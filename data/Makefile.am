appdatadir = $(datadir)/appdata
appdata_DATA = budgie-haste-applet.appdata.xml

gsettings_SCHEMAS = \
	com.github.cybre.haste-applet.gschema.xml

EXTRA_DIST = \
	$(appdata_DATA) \
	$(gsettings_SCHEMAS) \
	com.github.cybre.haste-applet.gschema.xml \
	plugin.gresource.xml \
	settings.ui \
	style.css

plugin_resources = $(shell glib-compile-resources --sourcedir=$(top_srcdir)/data --generate-dependencies $(top_srcdir)/data/plugin.gresource.xml)

BUILT_SOURCES = \
	plugin-resources.h \
	plugin-resources.c

# resources
plugin-resources.h: $(top_srcdir)/data/plugin.gresource.xml $(plugin_resources)
	glib-compile-resources --target=$@ --sourcedir=$(top_srcdir)/data --generate-header --c-name haste_applet $<

plugin-resources.c: $(top_srcdir)/data/plugin.gresource.xml $(plugin_resources)
	glib-compile-resources --target=$@ --sourcedir=$(top_srcdir)/data --generate-source --c-name haste_applet $<

@GSETTINGS_RULES@
