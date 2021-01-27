#!/usr/bin/env bash
set -e

function ap_main {
	local AP_PWD=${PWD:-"."}

	read -p "name: " _name
	[ ! -d "$_name" ] && echo "Error: '$_name' does not exist!" && exit 1
	read -p "container id: " _cid
	
	docker commit "$_cid" test_image
	docker container rm "$_cid"
	docker run -it --rm -v "$AP_PWD"/_pkg:/_pkg -v "$AP_PWD"/"$_name":/_build test_image /usr/bin/bash
	docker image rm test_image
}

ap_main $@
