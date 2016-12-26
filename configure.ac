AC_INIT([budgie-haste-applet], 0.2.8, [stfric369@gmail.com], [budgie-haste-applet], [https://github.com/cybre/budgie-haste-applet])
AC_CONFIG_AUX_DIR([build-aux])
AM_INIT_AUTOMAKE([-Wno-portability no-dist-gzip dist-xz foreign subdir-objects])
AC_PROG_CC
AC_PROG_CC_STDC
LT_PREREQ(2.2)
AC_CONFIG_HEADERS([config.h])
AC_PREFIX_DEFAULT(/usr/local)
AM_SILENT_RULES([yes])
LT_INIT([disable-static])
AC_CONFIG_MACRO_DIR([m4])

GLIB_GSETTINGS

m4_define([budgie_required_version], [2])

# Note budgie-1.0 depends on peas, gtk, etc. Sorta your package managers
# business to make sure those deps are satisfied.
# Also note this is just for the C and Vala subprojects!
PKG_CHECK_MODULES(BUDGIE_PLUGIN,
        budgie-1.0 >= budgie_required_version
)

PKG_CHECK_MODULES(SOUP,
        libsoup-2.4 >= 2.50.0
)

# Required only for Vala applets.
AM_PROG_VALAC([0.28], [], [AC_MSG_ERROR([valac is required to build Vala applets])])

IT_PROG_INTLTOOL([0.50.0])
GETTEXT_PACKAGE=budgie-haste-applet
AC_SUBST(GETTEXT_PACKAGE)
AC_DEFINE_UNQUOTED(GETTEXT_PACKAGE, "$GETTEXT_PACKAGE",
                   [The prefix for our gettext translation domains.])

AC_CONFIG_FILES([Makefile
                 budgie-haste-applet/Makefile
                 data/Makefile
                 po/Makefile.in])

AC_OUTPUT

AM_GLIB_GNU_GETTEXT

AC_MSG_RESULT([
        budgie-haste-applet $VERSION
        ========

        prefix:                 ${prefix}
        libdir:                 ${libdir}
        sysconfdir:             ${sysconfdir}
        exec_prefix:            ${exec_prefix}
        bindir:                 ${bindir}
        datarootdir:            ${datarootdir}

        compiler:               ${CC}
        cflags:                 ${CFLAGS}
        ldflags:                ${LDFLAGS}
])
