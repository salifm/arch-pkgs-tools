#!/usr/bin/env bash
set -e

function ap_main {
	[ -f /etc/ap-tools.conf ] && source /etc/ap-tools.conf
	local AP_PKGEXT=${AP_PKGEXT:-".pkg.tar.zst"}

	local AP_PWD=${PWD:-"."}

	read -p "name: " _name
	[ ! -d "$_name" ] && echo "Error: '$_name' does not exist!" && exit 1

	mkdir -p ./_pkg/tmp
	docker run \
		$([ -z "$AP_DEBUG" ] && echo -n "--rm" || echo -n "") \
		-v "$AP_PWD"/_pkg/tmp:/_pkg \
		-v "$AP_PWD"/"$_name":/_build \
		arch-pkgs:latest /usr/local/bin/ap-build
	cp --no-preserve=mode,ownership ./_pkg/tmp/*"$AP_PKGEXT" ./_pkg/
	rm -rf ./_pkg/tmp
	[ ! -z "$AP_GPG_KEY" ] && gpg --detach-sign --use-agent -u "$AP_GPG_KEY" --no-armor ./_pkg/*"$AP_PKGEXT"
}

ap_main $@
