#!/bin/bash

set -eu

mkdir -p /tmp/mkdocs

echo "Fetching latest mkdocs-material"
curl -sL https://api.github.com/repos/squidfunk/mkdocs-material/tarball | tar -C /tmp/mkdocs -xz --strip-components 1 -f -

echo "Removing old mkdocs files"
rm -rf ./material

echo "Copying new files to docs/"
cp -rf /tmp/mkdocs/material .

echo "Remove 404 file to not interfere with our main 404 file from appstore"
rm ./material/404.html

echo "Cleanup tmp files"
rm -rf /tmp/mkdocs

echo "Done."
echo ""
echo "Now test if it works and commit the old file removal and add new files to repo"
echo ""
