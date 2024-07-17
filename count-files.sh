#!/bin/bash

# Check if the directory path argument is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <directory-path>"
  exit 1
fi

DIRECTORY_PATH="C:/Users/GiridharRathod/Learn-Shell"

# Check if the given path is a directory
if [ ! -d "$DIRECTORY_PATH" ]; then
  echo "Error: '$DIRECTORY_PATH' is not a directory."
  exit 1
fi

# Count the number of files (excluding subdirectories) in the specified directory
FILE_COUNT=$(find "$DIRECTORY_PATH" -maxdepth 1 -type f | wc -l)

# Output the result
echo "Number of files in '$DIRECTORY_PATH': $FILE_COUNT"
