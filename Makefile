
pkgname := losswav

.SILENT:
.PHONY: all dist dist-clean install clean help update-version clear-version configure build

all: configure build

install:
	cd build && \
	meson install && \
	:

clean:
	rm -rf build && \
	:

help:
	echo "Please provide a target:" ; \
	echo "  [default]   - configure and build" ; \
	echo "   install    - install to system" ; \
	echo "   clean      - delete build dir" ; \
	:

update-version:
	version=$(shell git describe --tags --abbrev=7 | sed -E 's/^[^0-9]*//;s/-([0-9]*-g.*)$$/.r\1/;s/-/./g') && \
	meson rewrite kwargs set project / version $$version && \
	echo "project version: $$version" && \
	:

clear-version:
	meson rewrite kwargs delete project / version - && \
	:

configure:
	meson setup build && \
	:

build:
	export PKG_CONFIG_PATH="$(pkgconf_path)" && \
	cd build && \
	ninja && \
	:

dist:
	export version=$(shell git describe --tags --abbrev=7 | sed -E 's/^[^0-9]*//;s/-([0-9]*-g.*)$$/.r\1/;s/-/./g') && \
	echo "... $${version} ..." && \
	export pkgdir="$(pkgname)_$$version" && \
	echo "... $${pkgdir} ..." && \
	mkdir -p "$${pkgdir}" && \
	cp --reflink=auto -r -t "$${pkgdir}/" -- data source config* *.md Makefile meson* && \
	pushd "$${pkgdir}" && \
	echo "rewrite version..." && \
	meson rewrite kwargs set project / version $$version && \
	popd && \
	echo "tar..." && \
	tar -c -J --numeric-owner --owner=0 -f "$${pkgdir}.orig.tar.xz" "$${pkgdir}" && \
	:

dist-clean:
	rm -rf $(pkgname)_*/ && \
	rm -f $(pkgname)_*.orig.tar.xz && \
	:
