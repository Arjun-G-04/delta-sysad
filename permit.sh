#!/bin/bash

#Create necessary groups
groupadd students
groupadd wardens

filePath="/home/arjun/Documents/delta-sysad/studentDetails.txt"
# read -p 'Enter file path: ' filePath

while read line
do
    
    read -a studentData <<< "$line"
    name=${studentData[0]}
    hostel=${studentData[2]}
    roomno=${studentData[3]}

    #Assign the users to appropriate groups
    usermod -aG students $name
    usermod -aG wardens $hostel

    #Give owner permissions to student home directories
    chown $name /home/$hostel/$roomno/$name

done < $filePath