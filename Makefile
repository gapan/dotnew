DESTDIR ?= /

mo:
	for i in `ls po/*.po`; do \
		echo "Compiling $$i..."; \
		msgfmt $$i -o `echo $$i | sed "s/\.po//"`.mo; \
	done
	intltool-merge po/ -d -u dotnew.desktop.in dotnew.desktop
	intltool-merge po/ -d -u dotnew-kde.desktop.in dotnew-kde.desktop

pot:
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

po:
	cd po
	for i in `ls *.po`; do \
		msgmerge -U $$i dotnew.pot; \
	done
	cd ..

clean:
	rm -f dotnew.desktop
	rm -f dotnew-kde.desktop
	rm -f po/*.po~
	rm -f po/*.mo

install:
	install -d -m 755 $(DESTDIR)/usr/sbin
	install -d -m 755 $(DESTDIR)/usr/share/applications
	install -d -m 755 $(DESTDIR)/usr/share/dotnew
	install -m 755 src/dotnew $(DESTDIR)/usr/sbin/
	install -m 755 src/dotnew-gtk $(DESTDIR)/usr/sbin/
	install -m 644 src/dotnew-gtk.glade $(DESTDIR)/usr/share/dotnew/
	install -m 644 dotnew.desktop $(DESTDIR)/usr/share/applications/
	install -m 644 dotnew-kde.desktop $(DESTDIR)/usr/share/applications/
	install -d -m 755 $(DESTDIR)/usr/share/icons/hicolor/scalable/apps/
	install -m 644 icons/dotnew.svg $(DESTDIR)/usr/share/icons/hicolor/scalable/apps/
	install -d -m 755 $(DESTDIR)/usr/share/icons/hicolor/scalable/actions/
	install -m 644 icons/dotnew-vimdiff.svg $(DESTDIR)/usr/share/icons/hicolor/scalable/actions/
	for i in 32 24 22 16; do \
		install -d -m 755 \
		$(DESTDIR)/usr/share/icons/hicolor/$${i}x$${i}/apps/ \
		2> /dev/null; \
		install -m 644 icons/dotnew-$$i.png \
		$(DESTDIR)/usr/share/icons/hicolor/$${i}x$${i}/apps/dotnew.png; \
		install -d -m 755 \
		$(DESTDIR)/usr/share/icons/hicolor/$${i}x$${i}/actions/ \
		2> /dev/null; \
		install -m 644 icons/dotnew-vimdiff-$$i.png \
		$(DESTDIR)/usr/share/icons/hicolor/$${i}x$${i}/actions/dotnew-vimdiff.png; \
	done
	for i in `ls po/*.po|sed "s/po\/\(.*\)\.po/\1/"`; do \
		install -d -m 755 $(DESTDIR)/usr/share/locale/$$i/LC_MESSAGES; \
		install -m 644 po/$$i.mo $(DESTDIR)/usr/share/locale/$$i/LC_MESSAGES/dotnew.mo; \
	done

.PHONY: all man mo updatepo pot clean install
