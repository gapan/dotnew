#!/bin/sh

cd locale

for i in fr el de es; do
	msgfmt $i.po -o $i.mo
done

