#!/bin/bash

# Ensure the script exits on errors
set -e

# Check if the version.txt file exists
if [ ! -f version.txt ]; then
    echo "version.txt file does not exist."
    exit 1
fi

# Read the current version from version.txt
current_version=$(cat version.txt)
echo "Current version is $current_version"

# Define a function to increment the version
increment_version() {
    local version=$1
    local part=$2
    IFS='.' read -r major minor patch <<< "$version"

    case "$part" in
        major)
            major=$((major + 1))
            minor=0
            patch=0
            ;;
        minor)
            minor=$((minor + 1))
            patch=0
            ;;
        patch)
            patch=$((patch + 1))
            ;;
        *)
            echo "Invalid part specified. Use 'major', 'minor', or 'patch'."
            exit 1
            ;;
    esac

    echo "$major.$minor.$patch"
}

# Determine the version increment based on the commit message
increment_part="patch"
if git log -1 --pretty=%B | grep -q '\[major\]'; then
    increment_part="major"
elif git log -1 --pretty=%B | grep -q '\[minor\]'; then
    increment_part="minor"
fi

# Increment the version
new_version=$(increment_version "$current_version" "$increment_part")
echo "New version will be $new_version"

# Write the new version to version.txt
echo "$new_version" > version.txt

# Commit and push the new version
git config user.name "github-actions"
git config user.email "actions@github.com"
git add version.txt
git commit -m "Bump version to $new_version"
git push origin main
