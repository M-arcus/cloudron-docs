#!/bin/bash

set -eu

echo "Installing mkdocs"
sudo pip install mkdocs==0.17.1

echo "Installing mkdocs-material"
sudo pip install mkdocs-material==2.6.0

echo "Done."
