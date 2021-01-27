#!/usr/bin/env bash
set -e

function ap_main {
	read -p "name: " _name
	[ -d "$_name" ] && echo "Error: '$_name' already exist!" && exit 1
	echo "types:
	 1: PKGBUILD.proto
	 2: PKGBUILD-vcs.proto
	 3: PKGBUILD-split.proto"
	read -p "type (1|2|3): " _type
	case "$_type" in
		"1")
			mkdir -p "$_name"
			cp /usr/share/pacman/PKGBUILD.proto ./"$_name"/PKGBUILD
			;;
		"2")
			mkdir -p "$_name"
			cp /usr/share/pacman/PKGBUILD-vcs.proto ./"$_name"/PKGBUILD
			;;
		"3")
			mkdir -p "$_name"
			cp /usr/share/pacman/PKGBUILD-split.proto ./"$_name"/PKGBUILD
			;;
		*)
			echo "Invalid type!"
			exit 1
			;;
	esac
}

ap_main $@
