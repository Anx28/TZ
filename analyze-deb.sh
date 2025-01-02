#!/bin/bash

# Check if a .deb file is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <path-to-deb-file>"
    exit 1
fi

# Ensure the provided file exists and is a .deb file
deb_file="$1"
if [[ ! -f "$deb_file" || "${deb_file##*.}" != "deb" ]]; then
    echo "Error: File not found or not a .deb file"
    exit 1
fi

# Create a temporary directory to extract .deb contents
temp_dir=$(mktemp -d)

# Extract the .deb file
dpkg-deb -x "$deb_file" "$temp_dir" 2>/dev/null
dpkg-deb -e "$deb_file" "$temp_dir/DEBIAN" 2>/dev/null

# Extract package name and dependencies
control_file="$temp_dir/DEBIAN/control"
if [[ -f "$control_file" ]]; then
    package_name=$(grep '^Package:' "$control_file" | awk '{print $2}')
    dependencies=$(grep '^Depends:' "$control_file" | sed 's/^Depends: //')
    
    echo "Package Name: $package_name"
    echo "Dependencies:"
    if [[ -n "$dependencies" ]]; then
        echo "$dependencies" | tr ',' '\n' | sed 's/^ //'
    else
        echo "No dependencies listed."
    fi
else
    echo "Error: Failed to locate control file in the .deb package."
    exit 1
fi

# Cleanup
rm -rf "$temp_dir"
