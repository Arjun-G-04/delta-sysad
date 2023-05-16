#!/bin/bash

filePath="/home/arjun/Documents/delta-sysad/studentDetails.txt"
# read -p 'Enter file path: ' filePath

# Groups: 
# HAD + Each Hostel
# All students

#Creating each group
groupadd allStudents
while read line
do

    read -a studentData <<< "$line"
    name=${studentData[0]}
    hostel=${studentData[2]}

    #HADHostel groups
    if !(grep -q "HAD$hostel" /etc/group) ;
    then
        groupadd "HAD$hostel"
    fi
done < $filePath

#Assigning group members
while read line
do
    read -a studentData <<< "$line"
    name=${studentData[0]}
    hostel=${studentData[2]}

    usermod -aG allStudents $name
    usermod -aG HAD$hostel $hostel
    usermod -aG HAD$hostel HAD
done < $filePath

#Change owners
chown -R HAD:allStudents /home/HAD

while read line
do
    read -a studentData <<< "$line"
    hostel=${studentData[2]}
    chown -R root:HAD$hostel /home/$hostel
done < $filePath

while read line
do
    read -a studentData <<< "$line"
    name=${studentData[0]}
    hostel=${studentData[2]}
    roomno=${studentData[3]}
    chown -R $name:HAD$hostel /home/$hostel/$roomno/$name
done < $filePath

# Update permissions
chmod -R 760 /home/HAD

while read line
do
    read -a studentData <<< "$line"
    hostel=${studentData[2]}
    chmod -R 770 /home/$hostel
done < $filePath

while read line
do
    chmod -R 774 /home/$hostel/announcements.txt
    chmod -R 774 /home/$hostel/feeDefaulters.txt
done < $filePath

while read line
do
    read -a studentData <<< "$line"
    name=${studentData[0]}
    hostel=${studentData[2]}
    roomno=${studentData[3]}
    chmod -R 470 /home/$hostel/$roomno/$name
done < $filePath

echo "Updated permissions!"