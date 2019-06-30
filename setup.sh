#!/bin/bash

set -euo pipefail

# do not do anything if .cloneonly file is found
if [ -f '.cloneonly' ]; then
	echo "not running this script on this directory"
	exit 0
fi

# check if string marker is already there
if [ ! -z "`grep '#.init' Vagrantfile`" ]; then
	echo "skipping init, Vagrantfile template is already initiazlied"
	echo ""
else
	if [ $# -eq 0 ]; then
		echo "error: appname required. rerun this script and pass an application name"
		exit 1
	fi
	APPNAME=$1

	# https://stackoverflow.com/questions/1194882/how-to-generate-random-number-in-bash/1195035
	APPIP=$((11 + RANDOM % 254))

	sed -i "s/#APPNAME#/$APPNAME/; s/#APPIP#/$APPIP/" Vagrantfile

	# everything made it without error, inject string marker
	echo '#.init' >> Vagrantfile
fi

vagrant up && vagrant ssh
