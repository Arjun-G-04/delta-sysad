#!/bin/bash

#Alias genStudent in .bashrc runs this file

# Create HAD user and home directory
useradd HAD
mkdir /home/HAD
chown HAD /home/HAD
cp /home/arjun/Documents/delta-sysad/mess.txt /home/HAD/mess.txt
echo -e "[x] Created HAD user and home directory\n"

# Student details file input
# filePath="/home/arjun/Documents/delta-sysad/studentDetails.txt"
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

#Creating students home directories
echo -e "\nCreating student home directories............"
depts=("CSE" "ECE" "EEE" "ME" "ICE" "PRD" "MME" "CL" "CHE")
while read line
do
    #Extracting all data
    read -a studentData <<< "$line"
    name=${studentData[0]}
    rollno=${studentData[1]}
    hostel=${studentData[2]}
    roomno=${studentData[3]}
    mess=${studentData[4]}
    dept=${depts[$((RANDOM % 9))]}
    if [ -d "/home/$hostel/$roomno/$rollno" ]; 
    then
        echo "$name already present"
    else
        useradd $name
        mkdir /home/$hostel/$roomno
        mkdir /home/$hostel/$roomno/$name
        echo -e "Name $name\nRollNo $rollno\nDept $dept\nYear 1\nHostel $hostel\nMess $mess\nMessPreference\n" > /home/$hostel/$roomno/$name/userDetails.txt
        echo -e "TuitionFee 0\nHostelRent 0\nServiceCharge 0\nMessFee 0\n" > /home/$hostel/$roomno/$name/fees.txt
        echo "[x] Created $name user and home directory"
    fi
done < $filePath