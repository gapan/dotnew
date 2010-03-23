#!/bin/sh

cd po

for i in `ls *.po|sed "s/\.po//"`; do
	msgfmt $i.po -o $i.mo
done

intltool-merge po/ -d -u dotnew.desktop.in dotnew.desktop
intltool-merge po/ -d -u dotnew-kde.desktop.in dotnew-kde.desktop

