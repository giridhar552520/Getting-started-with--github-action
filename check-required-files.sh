#!/bin/bash

# Define the list of required files
required_files=("README.md" "LICENSE" ".gitignore")

# Initialize a flag to check if any files are missing
missing_files=false

# Loop through the list and check if each file exists
for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Error: $file is missing"
    missing_files=true
  fi
done

# Exit with a non-zero status if any files are missing
if [ "$missing_files" = true ]; then
  exit 1
fi
