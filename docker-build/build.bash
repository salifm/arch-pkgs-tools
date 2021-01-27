#!/usr/bin/env bash
set -e

function ap_main {
	[ -f /etc/ap-tools.conf ] && source /etc/ap-tools.conf
	local AP_CONFIG=${AP_CONFIG:-"._config"}
	[ -f "$AP_CONFIG" ] && source "$AP_CONFIG"
	local AP_PACKAGER=${AP_PACKAGER:-"Anonymous"}
	local AP_PKGEXT=${AP_PKGEXT:-".pkg.tar.zst"}
	local AP_SRCEXT=${AP_SRCEXT:-".src.tar.zst"}
	local AP_NODEPS=${AP_NODEPS:-"-s"}

	local AP_BUILD_DIR="/_build"
	local AP_OUT_DIR="/_pkg"

	cd "$AP_BUILD_DIR"
	chown -R makepkg:users "$AP_BUILD_DIR"

	sudo -u makepkg \
			SRCDEST=/home/makepkg/build/srcdest \
			SRCPKGDEST=/home/makepkg/build/srcpkgdest \
			LOGDEST=/home/makepkg/build/logdest \
			BUILDDIR=/home/makepkg/build/build \
			PKGDEST=/home/makepkg/build/out \
			PACKAGER="$AP_PACKAGER" \
			PKGEXT="$AP_PKGEXT" \
			SRCEXT="$AP_SRCEXT" \
			AP_PASS="$AP_PASS" \
			makepkg --noconfirm $AP_NODEPS -f
	sudo -u makepkg makepkg --printsrcinfo > .SRCINFO
	mv /home/makepkg/build/out/* "$AP_OUT_DIR"
}

ap_main $@
