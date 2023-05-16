#!/bin/bash

filePath="/home/arjun/Documents/delta-sysad/studentDetails.txt"
# read -p 'Enter file path: ' filePath

# Set HAD as owner and root as group owner of HAD and Hostel home directories and subdirectories
# Disable permissions for anyone else
chown -R HAD:root /home/HAD
chmod 770 /home/HAD
while read line
do
    read -a studentData <<< "$line"
    hostel=${studentData[2]}
    chown -R HAD:root /home/$hostel 
    chmod -R 770 /home/$hostel
done < $filePath

# Using ACL (Access Control List) setting up all permissions
while read line
do
    read -a studentData <<< "$line"
    name=${studentData[0]}
    rollno=${studentData[1]}
    hostel=${studentData[2]}
    roomno=${studentData[3]}

    # Students home directory permission
    setfacl -R -m u:$name:r-- /home/$hostel/$roomno/$name

    # announcements.txt and feeDefaulters.txt permission
    setfacl -m u:$name:r-- /home/$hostel/announcements.txt
    setfacl -m u:$name:r-- /home/$hostel/feeDefaulters.txt

    # Hostel home directory permission
    setfacl -R -m u:$hostel:rw- /home/$hostel

    # mess.txt permission
    setfacl -m u:$name:rw- /home/HAD/mess.txt

done < $filePath

echo "Completed set up of all permissions! Use getfacl to see the permissions."