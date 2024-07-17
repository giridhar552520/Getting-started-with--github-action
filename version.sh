#!/bin/bash

set -e

# Path to the version file
VERSION_FILE="version.txt"

# Read the current version from the file
current_version=$(cat $VERSION_FILE)
echo "Current version: $current_version"

# Split the version number into major, minor, and patch
IFS='.' read -r major minor patch <<< "$current_version"

# Increment the patch version by 1
new_patch=$((patch + 1))

# Update the version file with the new version
new_version="$major.$minor.$new_patch"
echo "New version: $new_version"

echo $new_version > $VERSION_FILE
