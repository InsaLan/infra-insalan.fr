#!/bin/bash

# TODO Check for required executables

function deploy_doc {
	if [ "$#" -ne "2" ]; then
		echo "Expected 2 arguments for deploy_doc, found $#" >&2
		return
	fi

	SRC_URL=$1
	DST_DIR=$2

	echo "Starting deploiement for $2" >&2

	TAR_GZ=${SRC_URL##*/}

	curl -sL "$SRC_URL" --output "$TAR_GZ"

	TO_DEPLOY=$(tar -tzf "$TAR_GZ" | head -1 | cut -f1 -d"/")

	tar -xzf "$TAR_GZ" | head -1 | cut -f1 -d"/"

	# Backup current version and delete previous backup (if any)
	if [ -d "$DST_DIR" ]; then
		if [ -d "$DST_DIR.old" ]; then
			rm -rf "$DST_DIR.old"
		fi
		mv "$DST_DIR" "$DST_DIR.old"
	fi

	mv "$TO_DEPLOY" "$DST_DIR"
}

# Fetch arguments
MAPPINGS=$(cat ${1:-mappings.txt})

# Create a temporary working directory
TMP_DIR=$(mktemp -d)
cd $TMP_DIR

while read -r src_url dst_dir; do
	deploy_doc $src_url $dst_dir
done <<< $MAPPINGS

# Clean-up temporary directory
rm -rf $TMP_DIR
