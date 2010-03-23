#!/bin/sh

install -d -m 755 $DESTDIR/usr/sbin
install -d -m 755 $DESTDIR/usr/share/applications
install -m 755 dotnew $DESTDIR/usr/sbin/
install -m 644 dotnew.desktop $DESTDIR/usr/share/applications/
install -m 644 dotnew-kde.desktop $DESTDIR/usr/share/applications/

for i in fr el de es; do
	install -d -m 755 $DESTDIR/usr/share/locale/$i/LC_MESSAGES
	install -m 644 locale/$i.mo $DESTDIR/usr/share/locale/$i/LC_MESSAGES/dotnew.mo
done
