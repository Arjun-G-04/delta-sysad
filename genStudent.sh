#!/bin/bash

#Alias genStudent in .bashrc runs this file

# Create HAD user and home directory
useradd HAD
mkdir /home/HAD
chown HAD /home/HAD
echo -e "[x] Created HAD user and home directory\n"

# Student details file input
read -p 'Enter file path: ' filePath

# Create Hostel home directories
echo -e "\nCreating Hostels home directories............"
while read line
do
    read -a studentData <<< "$line"
    hostel=${studentData[2]}
    if [ -d "/home/$hostel" ]; 
    then
        echo "$hostel already present"
    else
        useradd $hostel
        mkdir /home/$hostel
        chown $hostel /home/$hostel
        touch /home/$hostel/announcements.txt
        touch /home/$hostel/feeDefaulters.txt
        echo "[x] Created $hostel user and home directory"
    fi
done < $filePath