#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Requesting administrative privileges..."
    sudo "$0" "$@"
    exit
fi

# Run the system specs script
bash "$(dirname "$0")/system_specs.sh"
