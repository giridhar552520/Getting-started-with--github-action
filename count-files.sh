#!/bin/bash

# Check if a directory path is provided as an argument
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <C:\Users\GiridharRathod\Learn-Shell>"
  exit 1
fi

DIRECTORY=$1

# Check if the directory exists
if [ ! -d "$DIRECTORY" ]; then
  echo "Directory $DIRECTORY does not exist."
  exit 1
fi

# Count the number of files in the directory (excluding subdirectories)
FILE_COUNT=$(find "$DIRECTORY" -maxdepth 1 -type f | wc -l)

# Output the result
echo "The number of files in '$DIRECTORY' is: $FILE_COUNT"

# Create a result file for GitHub Actions to use
echo "The number of files in '$DIRECTORY' is: $FILE_COUNT" > .github/workflows/count-files-result.txt

