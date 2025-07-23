#!/bin/bash

set -xe

SRC_DIR=$(readlink -f ../src)
DESTINATION_DIR=/var/www/html

echo "SRC_DIR=$SRC_DIR"
echo "DESTINATION_DIR=$DESTINATION_DIR"

# validate folders exist
stat $SRC_DIR
stat $DESTINATION_DIR

sudo cp -r "$SRC_DIR/"* "$DESTINATION_DIR"
