#!/bin/bash

user=$(whoami)
counts=(2 35 35)
declare -A messCount
messCount["1"]=2
messCount["2"]=35
messCount["3"]=35

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
    #Allocation
    while read line
    do
        read -a data <<< "$line"

        if echo ${data[0]} | grep -q '^[0-9]*$'
        then
            name=${data[1]}
            prefOne=${data[2]}
            prefTwo=${data[3]}
            prefThree=${data[4]}
            prefs=($prefOne $prefTwo $prefThree)
            for item in "${prefs[@]}"
            do
                if [ $((${messCount["$item"]} - 1)) -ge 0 ]
                then
                    path=$(find /home -type d -name $name)
                    echo "Mess $item" >> $path/userDetails.txt
                    messCount["$item"]=$((${messCount["$item"]} - 1))
                    break
                fi
            done
        fi
    done < /home/HAD/mess.txt
fi