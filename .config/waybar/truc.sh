#!/bin/sh

nix-shell -p python312Packages.pygobject3
./mediaplayr.py
