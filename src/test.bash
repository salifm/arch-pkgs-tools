#!/usr/bin/env bash
set -e

function ap_main {
	local AP_PWD=${PWD:-"."}

	docker run -it --rm -v "$AP_PWD"/_pkg:/_pkg arch-pkgs:latest /usr/bin/bash
}

main $@
