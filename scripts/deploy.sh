#!/bin/bash

set -xe

SCRIPTS_DIR=/home/ta1/src/my_website/scripts

echo "verifying scripts dir"
stat $SCRIPTS_DIR
cd $SCRIPTS_DIR

echo "pulling latest version"
git pull

echo "updating html"
stat update_html.sh
./update_html.sh
