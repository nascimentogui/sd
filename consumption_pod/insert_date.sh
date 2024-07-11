#!/bin/bash

# Directory containing the files
directory="log_pod_1701_2002"

# Loop through each file in the directory
for file in "$directory"/*; do
    # Check if the file is a regular file
    if [ -f "$file" ]; then
        echo "Processing file: $file"
        
        # Create a temporary file to store the modified content
        temp_file=$(mktemp)
        
        # Loop through each line in the file
        while IFS= read -r line; do
            # Prepend the name to each line and write it to the temporary file
            echo "$file, $line" >> "$temp_file"
        done < "$file"
        
        # Overwrite the original file with the modified content
        mv "$temp_file" "$file"
        
        echo "Name inserted into each line of $file"
    fi
done