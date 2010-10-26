#!/bin/sh

install -d -m 755 $DESTDIR/usr/sbin
install -d -m 755 $DESTDIR/usr/share/applications
install -d -m 755 $DESTDIR/usr/share/dotnew
install -m 755 src/dotnew $DESTDIR/usr/sbin/
install -m 755 src/dotnew-gtk $DESTDIR/usr/sbin/
install -m 644 src/dotnew-gtk.glade $DESTDIR/usr/share/dotnew/
install -m 644 dotnew.desktop $DESTDIR/usr/share/applications/
install -m 644 dotnew-kde.desktop $DESTDIR/usr/share/applications/

# Install icons
install -d -m 755 $DESTDIR/usr/share/icons/hicolor/scalable/apps/
install -m 644 icons/dotnew.svg $DESTDIR/usr/share/icons/hicolor/scalable/apps/
install -d -m 755 $DESTDIR/usr/share/icons/hicolor/scalable/actions/
install -m 644 icons/dotnew-vimdiff.svg $DESTDIR/usr/share/icons/hicolor/scalable/actions/

for i in 32 24 22 16; do
	install -d -m 755 \
	$DESTDIR/usr/share/icons/hicolor/${i}x${i}/apps/ \
	2> /dev/null
	install -m 644 icons/dotnew-$i.png \
	$DESTDIR/usr/share/icons/hicolor/${i}x${i}/apps/dotnew.png
	install -d -m 755 \
	$DESTDIR/usr/share/icons/hicolor/${i}x${i}/actions/ \
	2> /dev/null
	install -m 644 icons/dotnew-vimdiff-$i.png \
	$DESTDIR/usr/share/icons/hicolor/${i}x${i}/actions/dotnew-vimdiff.png
done

for i in `ls po/*.po|sed "s/po\/\(.*\)\.po/\1/"`; do
	install -d -m 755 $DESTDIR/usr/share/locale/$i/LC_MESSAGES
	install -m 644 po/$i.mo $DESTDIR/usr/share/locale/$i/LC_MESSAGES/dotnew.mo
done
