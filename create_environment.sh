#!/bin/bash

# Script to create submission reminder application environment
# Author: James Deng
# Date: June 19, 2025

set -e  # Exit on any error

echo "=== Submission Reminder App Environment Setup ==="
echo

# Prompt for user name
read -p "Enter your name: " user_name

# Validate input
if [[ -z "$user_name" ]]; then
    echo "Error: Name cannot be empty!"
    exit 1
fi

# Create main directory
app_dir="submission_reminder_${user_name}"
echo "Creating application directory: $app_dir"

if [[ -d "$app_dir" ]]; then
    echo "Warning: Directory $app_dir already exists. Removing it..."
    rm -rf "$app_dir"
fi

mkdir "$app_dir"
cd "$app_dir"

# Create subdirectories based on the provided structure
echo "Creating subdirectories..."
mkdir -p config modules assets

# Create config/config.env (exactly as provided)
echo "Creating config/config.env..."
cat > config/config.env << 'EOF'
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# Create modules/functions.sh (exactly as provided)
echo "Creating modules/functions.sh..."
cat > modules/functions.sh << 'EOF'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF

# Create modules/reminder.sh (exactly as provided)
echo "Creating modules/reminder.sh..."
cat > modules/reminder.sh << 'EOF'
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF

# Create assets/submissions.txt with original data plus 5 more students
echo "Creating assets/submissions.txt..."
cat > assets/submissions.txt << 'EOF'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Michael, Shell Navigation, not submitted
Sarah, Shell Navigation, submitted
James, Shell Navigation, not submitted
Emma, Git, submitted
Alex, Shell Navigation, not submitted
EOF

# Create startup.sh (you need to implement this)
echo "Creating startup.sh..."
cat > startup.sh << 'EOF'
#!/bin/bash

# Startup script for Submission Reminder Application
# This script initializes and runs the reminder application

set -e

echo "========================================="
echo "  SUBMISSION REMINDER APPLICATION"
echo "========================================="
echo

# Check if we're in the right directory
if [[ ! -d "config" || ! -d "modules" || ! -d "assets" ]]; then
    echo "Error: Please run this script from the application root directory"
    echo "Make sure you have the following directories: config, modules, assets"
    exit 1
fi

# Check if all required files exist
required_files=("config/config.env" "modules/functions.sh" "modules/reminder.sh" "assets/submissions.txt")

for file in "${required_files[@]}"; do
    if [[ ! -f "$file" ]]; then
        echo "Error: Required file '$file' not found!"
        exit 1
    fi
done

echo "All required files found. Starting application..."
echo

# Run the reminder application
bash modules/reminder.sh

echo
echo "========================================="
echo "Application completed successfully!"
echo "========================================="
EOF

# Make all .sh files executable
echo "Setting executable permissions for .sh files..."
find . -name "*.sh" -type f -exec chmod +x {} \;

echo
echo "=== Environment Setup Complete! ==="
echo "Application directory created: $app_dir"
echo "All files and directories have been created successfully."
echo
echo "To test the application:"
echo "1. cd $app_dir"
echo "2. ./startup.sh"
echo
