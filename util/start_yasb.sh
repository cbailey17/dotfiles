#!/bin/zsh

# Define the working directory
WORKING_DIR="/mnt/c/Users/abailey/Developer/yasb/src"

# Define the command to start YASB
COMMAND="powershell.exe -Command 'python main.py'"

# Check if YASB is already running
if ! ps aux | grep -v grep | grep "start_yasb.sh" > /dev/null; then
    # If not running, change to the working directory and start YASB
    echo "Starting up YASB..."
    cd $WORKING_DIR
    eval $COMMAND & 
fi

