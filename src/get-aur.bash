#!/usr/bin/env bash
set -e

function ap_main {
	read -p "name: " _name
	git clone --depth=1 https://aur.archlinux.org/"$_name".git
	[ -d "$_name"/.git ] && rm -rf ./"$_name"/.git
	[ -f "$_name"/.gitignore ] && rm -f ./"$_name"/.gitignore
	[ -f "$_name"/.SRCINFO ] && rm -f ./"$_name"/.SRCINFO
}

ap_main $@
