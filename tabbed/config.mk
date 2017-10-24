# tabbed version
VERSION = 0.6

# Customize below to fit your system

# paths
PREFIX = /usr/home/mytoh/huone/ohjelmat/tabbed
MANPREFIX = ${PREFIX}/share/man

# includes and libs
INCS = -I. -I/usr/local/include -I/usr/local/include/freetype2 -I/usr/include -I/usr/include/freetype2
LIBS = -L/usr/local/lib -L/usr/lib -lc -lX11 -lfontconfig -lXft

# flags
CPPFLAGS = -DVERSION=\"${VERSION}\" -D_DEFAULT_SOURCE
CFLAGS = -std=c99 -pedantic -Wall -Os ${INCS} ${CPPFLAGS}
LDFLAGS = -s ${LIBS}

# Solaris
#CFLAGS = -fast ${INCS} -DVERSION=\"${VERSION}\"
#LDFLAGS = ${LIBS}

# compiler and linker
CC = clang-devel
