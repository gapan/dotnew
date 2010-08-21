#!/bin/sh

cd po

for i in `ls *.po|sed "s/\.po//"`; do
	echo "Compiling $i..."
	msgfmt $i.po -o $i.mo
done

cd ..

intltool-merge po/ -d -u dotnew.desktop.in dotnew.desktop
intltool-merge po/ -d -u dotnew-kde.desktop.in dotnew-kde.desktop

