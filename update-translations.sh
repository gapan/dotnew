#!/bin/sh

intltool-extract --type="gettext/ini" dotnew.desktop.in
intltool-extract --type="gettext/ini" dotnew-kde.desktop.in
sed -i '/char \*s = N_("Dotnew");/d' *.in.h
xgettext --from-code=utf-8 -L shell -o po/dotnew.pot src/dotnew
xgettext --from-code=utf-8 -j -L C -kN_ -o po/dotnew.pot dotnew.desktop.in.h
xgettext --from-code=utf-8 -j -L C -kN_ -o po/dotnew.pot dotnew-kde.desktop.in.h

xgettext --from-code=utf-8 \
	-j \
	-x po/EXCLUDE \
	-L Glade \
	-o po/dotnew.pot \
	src/dotnew-gtk.glade

xgettext --from-code=utf-8 \
	-j \
	-L Python \
	-o po/dotnew.pot \
	src/dotnew-gtk

rm dotnew.desktop.in.h dotnew-kde.desktop.in.h

cd po
for i in `ls *.po`; do
	msgmerge -U $i dotnew.pot
done
rm -f ./*~


