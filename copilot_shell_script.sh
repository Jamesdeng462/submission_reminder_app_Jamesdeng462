#!/bin/bash

# Copilot script to update assignment name in configuration
# Author: James Deng

set -e

echo "=== Assignment Update Copilot ==="
echo

# Prompt for new assignment name
read -p "Enter the new assignment name: " new_assignment

# Validate input
if [[ -z "$new_assignment" ]]; then
    echo "Error: Assignment name cannot be empty!"
    exit 1
fi

# Find the submission reminder directory
app_dir=""
for dir in submission_reminder_*; do
    if [[ -d "$dir" ]]; then
        app_dir="$dir"
        break
    fi
done

if [[ -z "$app_dir" ]]; then
    echo "Error: No submission reminder application directory found!"
    echo "Please run create_environment.sh first."
    exit 1
fi

echo "Found application directory: $app_dir"

# Check if config file exists
config_file="$app_dir/config/config.env"
if [[ ! -f "$config_file" ]]; then
    echo "Error: Configuration file not found at $config_file"
    exit 1
fi

# Update the assignment name using sed
echo "Updating assignment name to: $new_assignment"
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_assignment\"/" "$config_file"

# Verify the change
echo "Configuration updated successfully!"
echo "New configuration:"
grep "ASSIGNMENT=" "$config_file"

echo
echo "Restarting the application with new assignment..."
echo

# Change to app directory and run startup script
cd "$app_dir"
./startup.sh

