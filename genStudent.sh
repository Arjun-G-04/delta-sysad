#!/bin/bash

#IFS=':' is the field separator
#Name RollNumber Hostel Room Mess MessPref

clear

if [ -d "./HAD" ]
then
    echo "Everything is already setup!"
    read -p "Press any key to go back to home...." any
    ./main.sh
else
    
    #read -p "Enter the Student Details file name: " file
    file="studentDetails.txt"

    mylist="apple banana orange"
    echo ${mylist[1]}


    #Name Rollno Hostel Room Mess
    #while read line
    #do
    #    echo "${line[2]}"
    #done < ./$file


fi