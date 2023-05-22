#!/bin/bash

#user=$(whoami)
user="Agate"
counts=(2 35 35)

if id -nG $user | grep -qw "allStudents" 
then
    read -p "Enter your mess preference order (eg. 2 1 3): " order

    #Update userDetails.txt
    path=$(find /home -type d -name $user)
    while read line
    do
        read -a data <<< "$line"
        if [ ${data[0]} = "RollNo" ]
        then
            rollno=${data[1]}
        fi
    done < $path/userDetails.txt
    echo "MessPreference $order" >> $path/userDetails.txt

    #Update mess.txt
    echo "$rollno $user $order" >> /home/HAD/mess.txt
else
    while read line
    do
        read -a data <<< "$line"

        if echo ${data[0]} | grep -q '^[0-9]*$'
        then
            prefOne=${data[2]}
            prefTwo=${data[3]}
            prefThree=${data[4]}
            prefs=($prefOne $prefTwo $prefThree)
            name=${data[1]}
            cond=false
            path=$(find /home -type d -name $name)
            while true
            do
                if [ ${counts[${prefs[0]}]} - 1 -ge 0 ]
                then
                    #
                
        fi

    done < /home/HAD/mess.txt
fi