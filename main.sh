#!/bin/bash

while true
do
    clear

    # Main Menu
    echo "Welcome to NITT Hostel and Mess Management Server"
    echo -e "\nHere are the list of commands available:"

    # Listing all commands
    count=1
    while read command
    do
        echo "$count. $command"
        count=$((count+1))
    done < ./admin_files/commands.txt

    # Input of command
    read -p "Enter command: " cmd

    # Execution of command
    if [ $cmd = "genStudent" ]
    then
        ./genStudent.sh
    else
        echo "nope"
    fi
done