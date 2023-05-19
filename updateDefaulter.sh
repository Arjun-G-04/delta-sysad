#!/bin/bash

# user=$(whoami)
user="Agate"

read -p "Enter last date for payment (YYYY:MM:DD): " lastDate

find /home/$user -type f -name fees.txt > /home/allFiles.txt

rm /home/$user/feeDefaulters.txt
while read line
do
    while read data
    do
        read -a feeData <<< "$data"
        cond=false
        paidOnTime=false
        if [ ${feeData[0]} = "Trans" ]
        then
            if [ ${feeData[0]} \< lastDate ]
            then
                paidOnTime=true
                cond=true
            else
                cond=true
            fi
        fi
    done < $line

    if [ $cond = false ] || [ $paidOnTime = false ]
    then
        IFS="\/"
        read -ra address <<< "$line"
        IFS=" "
        count=0
        reqDetails=()
        room=${address[3]}
        name=${address[4]}
        while read details
        do
            read -a detail <<< "$details" 
            reqDetails+=(${detail[1]})
        done < "/home/$user/$room/$name/userDetails.txt"
        rollno=${reqDetails[1]}
        echo "$name $rollno" >> /home/$user/feeDefaulters.txt
    fi
done < /home/allFiles.txt

rm /home/allFiles.txt

echo "Updated feeDefaulters.txt!"