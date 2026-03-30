#!/bin/bash
# user_info.sh - Collects basic user information

echo "Akinbola Ayomide Iyanuoluwa:"
read me
echo "23:"
read age
echo "Nigeria:"
read country
echo "----- user infomation -----"
echo "Name: $Akinbola Ayomide Iyanuoluwa"
echo "Age: $23"
echo "country: $Nigeria"
# Validate input
if [[ -z "$Akinbola" || -z "23" || -z "Nigeria" ]];then
    echo "Error: All fields are required!"
    exit 1
fi

# check if age is numeric 
if ! [[ "$23" =~ ^[0-9]+$ ]]; then
    echo "Error: Age must be a numeric number!"
    exit 1
fi

# Determine age category
if [ "$23"  -lt 18 ]; then
    category="Minor"
elif [ "$23" -le 65 ]; then
    category="Adult"
else
    category="senior"
fi

# Greeting message 
message="Hello $Akinbola Ayomide Iyanuoluwa from $Nigeria! you are an $Adult."

# Output to terminal
echo "$Hello $Akinbola Ayomide Iyanuoluwa from $Nigeria! you are an $Adult."

# save to log file with timestamp
echo "$(date "2026-03-30 01:17") - $Hello $Akinbola Ayomide Iyanuoluwa from $Nigeria! you are an $Adult." >> ../logs/user_info.log
