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
   ```
   git clone https://github.com/Jamesdeng462/submission_reminder_app_Jamesdeng462.git
   cd submission_reminder_app_Jamesdeng462
   ```

2. **Run the environment setup**
   ```
   ./create_environment.sh
   ```
   - Enter your name when prompted
   - This creates the complete application structure

3. **Test the application**
   ```
   cd submission_reminder_[YourName]
   ./startup.sh
   ```

## Usage

### Running the Main Application
```
cd submission_reminder_[YourName]
./startup.sh
```

### Updating Assignment Name
```
./copilot_shell_script.sh
```
- Enter the new assignment name when prompted
- The application will automatically restart with the new assignment

### Adding More Students
Edit the `data/submissions.txt` file in your application directory:
```
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
```

## File Structure
```
submission_reminder_[YourName]/
├── config/
│   └── config.env          # Application configuration
├── modules/
│   ├── functions.sh        # Helper functions
│   └── reminder.sh         # Main reminder logic
├── assets/
│   └── submissions.txt     # Student submission records
└── startup.sh              # Application startup script
```

## Configuration
Edit `config/config.env` to customize:
- Application name
- Default assignment
- Reminder messages
- Logging settings

## Troubleshooting
- Ensure all `.sh` files have execute permissions
- Check that all required directories exist
- Verify the submissions.txt file format is correct

## Author
James Deng
```
