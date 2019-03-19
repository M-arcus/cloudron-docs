#!/bin/bash

set -eu

echo "Installing mkdocs"
sudo pip install mkdocs==1.0.4

echo "Installing mkdocs-material"
sudo pip install mkdocs-material==3.0.3

echo "Installing pygments"
sudo pip install pygments

echo "Done."
