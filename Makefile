include config.mk

.POSIX:

all: $(PAGES:=.html) index.html

pages: $(PAGES:=.html)

.SUFFIXES: .7 .html

.7.html:
	mandoc -K utf-8 -O man=./%N.html,style=/style.css -T html $< > $@

clean:
	rm -f *.html

index.html: $(PAGES:=.7)
	cat index.html.head > index.html
	for i in $(PAGES:=.7); do printf '<tr><td><a href="%s.html">%s</a></td><td>%s</td></tr>\n' "$${i%%.7}" "$${i%%.7}" "$$(grep -m 1 '^\.Nd ' "$${i}" | cut -d' ' '-f2-')" >> index.html; done
	cat index.html.tail >> index.html
