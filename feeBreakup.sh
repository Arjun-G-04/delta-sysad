#!/bin/bash

user=$(whoami)
path=$(find /home -type d -name $user)
mv $path/fees.txt $path/oldFees.txt #Renaming file

read -p "Enter fees amount to pay: " total

while read line
do
    read -a values <<< "$line"
    type=${values[0]}
    if [ $type == "TuitionFee" ]
    then
        fees=${values[1]}
        add=$((total / 2))
        echo "$type $((fees + add))" >> $path/fees.txt
    elif [ $type == "HostelRent" ]
    then
        fees=${values[1]}
        add=$((total / 5))
        echo "$type $((fees + add))" >> $path/fees.txt
    elif [ $type == "ServiceCharge" ]
    then
        fees=${values[1]}
        add=$((total / 10))
        echo "$type $((fees + add))" >> $path/fees.txt
    elif [ $type == "MessFee" ] 
    then
        fees=${values[1]}
        add=$((total / 5))
        echo "$type $((fees + add))" >> $path/fees.txt
    else #In case that line is a record of transaction of form "Trans Date Amt"
        echo "${values[0]} ${values[1]} ${values[2]}" >> $path/fees.txt
    fi
done < $path/oldFees.txt

date=$(date +"%Y-%m-%d::%H:%M:%S")
echo "Trans $date $total" >> $path/fees.txt
rm $path/oldFees.txt

echo "Fees paid succesfully!"