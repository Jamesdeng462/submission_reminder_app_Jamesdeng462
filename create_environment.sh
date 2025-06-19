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

# Create subdirectories
echo "Creating subdirectories..."
mkdir -p config modules data

# Create config/config.env
echo "Creating config/config.env..."
cat > config/config.env << 'EOF'
APP_NAME="Student Submission Reminder"
ASSIGNMENT="Shell Permissions"
REMINDER_MESSAGE="Please submit your assignment before the deadline!"
LOG_LEVEL="INFO"
EMAIL_ENABLED=false
EOF

# Create modules/functions.sh
echo "Creating modules/functions.sh..."
cat > modules/functions.sh << 'EOF'
#!/bin/bash

# Functions for submission reminder app

# Function to load configuration
load_config() {
    if [[ -f "config/config.env" ]]; then
        source config/config.env
        echo "Configuration loaded successfully"
    else
        echo "Error: Configuration file not found!"
        exit 1
    fi
}

# Function to check if submissions file exists
check_submissions_file() {
    if [[ ! -f "data/submissions.txt" ]]; then
        echo "Error: submissions.txt file not found!"
        exit 1
    fi
}

# Function to display pending submissions
show_pending_submissions() {
    local assignment="$1"
    echo "=== Students with pending submissions for: $assignment ==="
    echo
    
    while IFS=',' read -r student_id name email assignment_name status; do
        # Skip header line
        if [[ "$student_id" == "StudentID" ]]; then
            continue
        fi
        
        # Check if assignment matches and status is pending
        if [[ "$assignment_name" == "$assignment" && "$status" == "Pending" ]]; then
            echo "Student ID: $student_id"
            echo "Name: $name"
            echo "Email: $email"
            echo "Status: $status"
            echo "---"
        fi
    done < data/submissions.txt
}

# Function to count pending submissions
count_pending() {
    local assignment="$1"
    local count=0
    
    while IFS=',' read -r student_id name email assignment_name status; do
        if [[ "$student_id" == "StudentID" ]]; then
            continue
        fi
        
        if [[ "$assignment_name" == "$assignment" && "$status" == "Pending" ]]; then
            ((count++))
        fi
    done < data/submissions.txt
    
    echo "$count"
}
EOF

# Create modules/reminder.sh
echo "Creating modules/reminder.sh..."
cat > modules/reminder.sh << 'EOF'
#!/bin/bash

# Main reminder script

# Source functions
source modules/functions.sh

# Main reminder function
run_reminder() {
    echo "Starting Submission Reminder Application..."
    echo
    
    # Load configuration
    load_config
    
    # Check if submissions file exists
    check_submissions_file
    
    # Display app info
    echo "Application: $APP_NAME"
    echo "Current Assignment: $ASSIGNMENT"
    echo
    
    # Show pending submissions
    show_pending_submissions "$ASSIGNMENT"
    
    # Show summary
    local pending_count=$(count_pending "$ASSIGNMENT")
    echo
    echo "=== Summary ==="
    echo "Total students with pending submissions: $pending_count"
    
    if [[ $pending_count -gt 0 ]]; then
        echo "Reminder: $REMINDER_MESSAGE"
    else
        echo "Great! All students have submitted their assignments."
    fi
}

# Run the reminder if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_reminder
fi
EOF

# Create data/submissions.txt with sample data
echo "Creating data/submissions.txt..."
cat > data/submissions.txt << 'EOF'
StudentID,Name,Email,Assignment,Status
S001,Deng,deng@gmail.com,Shell Basics,Pending
S002,Sarah,sarah@gmail.com,Shell Basics,Submitted
S003,Mike,mike@gmail.com,Shell Permissions,Pending
S004,Lisa,lisa@gmail.com,Shell I/O Redirections and filters,Submitted
S005,Tom,tom@gmail.com,Shell Basics,Pending
S006,Emma,emma@gmail.com,Shell Permissions,Pending
S007,James,james@gmail.com,Shell Permissions,Submitted
S008,Amy,amy@gmail.com,Shell I/O Redirections and filters,Pending
S009,David,david@gmail.com,Shell Permissions,Submitted
S010,Jennifer,jennifer@gmail.com,Shell Basics,Pending
EOF

# Create startup.sh
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
if [[ ! -d "config" || ! -d "modules" || ! -d "data" ]]; then
    echo "Error: Please run this script from the application root directory"
    echo "Make sure you have the following directories: config, modules, data"
    exit 1
fi

# Check if all required files exist
required_files=("config/config.env" "modules/functions.sh" "modules/reminder.sh" "data/submissions.txt")

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
chmod +x *.sh modules/*.sh

echo
echo "=== Environment Setup Complete! ==="
echo "Application directory created: $app_dir"
echo "All files and directories have been created successfully."
echo
echo "To test the application:"
echo "1. cd $app_dir"
echo "2. ./startup.sh"
echo
