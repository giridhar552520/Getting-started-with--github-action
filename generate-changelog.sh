#!/bin/bash

set -e  # Exit on any error

# Ensure there is a git repository
if [ ! -d ".git" ]; then
  echo "Not a git repository. Exiting."
  exit 1
fi

# Initialize changelog
CHANGELOG_FILE="CHANGELOG.md"

# Add header to the changelog
echo "# Changelog" > $CHANGELOG_FILE
echo "" >> $CHANGELOG_FILE
echo "## $(date +'%Y-%m-%d')" >> $CHANGELOG_FILE
echo "" >> $CHANGELOG_FILE

# Categorize commits
echo "Categorizing commits..."

# Define categories
FEATURES=""
BUG_FIXES=""
OTHER_CHANGES=""

while IFS= read -r COMMIT; do
  if [[ $COMMIT == feat:* ]]; then
    FEATURES+="- ${COMMIT/feat: /Feature: }\\n"
  elif [[ $COMMIT == fix:* ]]; then
    BUG_FIXES+="- ${COMMIT/fix: /Bug Fix: }\\n"
  else
    OTHER_CHANGES+="- ${COMMIT}\\n"
  fi
done <<< "$COMMITS"

# Add categorized commits to the changelog
if [ -n "$FEATURES" ]; then
  echo "### Features" >> $CHANGELOG_FILE
  echo "$FEATURES" >> $CHANGELOG_FILE
  echo "" >> $CHANGELOG_FILE
fi

if [ -n "$BUG_FIXES" ]; then
  echo "### Bug Fixes" >> $CHANGELOG_FILE
  echo "$BUG_FIXES" >> $CHANGELOG_FILE
  echo "" >> $CHANGELOG_FILE
fi

if [ -n "$OTHER_CHANGES" ]; then
  echo "### Other Changes" >> $CHANGELOG_FILE
  echo "$OTHER_CHANGES" >> $CHANGELOG_FILE
  echo "" >> $CHANGELOG_FILE
fi

echo "Changelog generated in $CHANGELOG_FILE"
