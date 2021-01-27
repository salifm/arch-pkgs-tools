#!/usr/bin/env bash
set -e

function ap_main {
	[ -f /etc/ap-tools.conf ] && source /etc/ap-tools.conf
	local AP_DOCKER_BUILD_DIR=${AP_DOCKER_BUILD_DIR:-"/tmp/docker-build"}

	mkdir -p "$AP_DOCKER_BUILD_DIR"
	cp /usr/share/ap-tools/Dockerfile "$AP_DOCKER_BUILD_DIR"/
	cp /usr/share/ap-tools/ap-build "$AP_DOCKER_BUILD_DIR"/
	cp /etc/ap-tools.conf "$AP_DOCKER_BUILD_DIR"/
	docker build -t arch-pkgs "$AP_DOCKER_BUILD_DIR"/
	rm -rf "$AP_DOCKER_BUILD_DIR"
}

ap_main $@
