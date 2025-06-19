# Submission Reminder Application

A Linux-based application that helps track and remind students about pending assignment submissions.

## Features
- Automated environment setup
- Student submission tracking
- Assignment management
- Flexible configuration

## Prerequisites
- Linux/Unix environment
- Bash shell
- Basic command line knowledge

## Installation & Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/Jamesdeng462/submission_reminder_app_Jamesdeng462.git
   cd submission_reminder_app_Jamesdeng462

Run the environment setup
bash./create_environment.sh

Enter your name when prompted
This creates the complete application structure


Test the application
bashcd submission_reminder_[YourName]
./startup.sh


Usage
Running the Main Application
bashcd submission_reminder_[YourName]
./startup.sh
Updating Assignment Name
bash./copilot_shell_script.sh

Enter the new assignment name when prompted
The application will automatically restart with the new assignment

Adding More Students
Edit the data/submissions.txt file in your application directory:
csvStudentID,Name,Email,Assignment,Status
S011,New Student,new@gmail.com,Math Assignment 1,Pending
File Structure
submission_reminder_[YourName]/
├── config/
│   └── config.env          # Application configuration
├── modules/
│   ├── functions.sh        # Helper functions
│   └── reminder.sh         # Main reminder logic
├── data/
│   └── submissions.txt     # Student submission records
└── startup.sh              # Application startup script
Configuration
Edit config/config.env to customize:

Application name
Default assignment
Reminder messages
Logging settings

Troubleshooting

Ensure all .sh files have execute permissions
Check that all required directories exist
Verify the submissions.txt file format is correct

Author
James Deng
