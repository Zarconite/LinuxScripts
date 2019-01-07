#!/bin/bash
ls /home/adminsa/folder | grep -v -i '^[a-z]' | grep .sql | sort -g | tee output.txt
file="/home/adminsa/output.txt"
while IFS= read -r line
do
number=$(echo "$line" | sed 's/^[^0-9]*//;s/[^0-9].*$//')
current=$(sqlite3 /home/adminsa/Linux.db "SELECT versionID FROM sql")
if [ "$current" -lt "$number" ]
then
sqlite3 /home/adminsa/Linux.db < /home/adminsa/folder/$line
sqlite3 /home/adminsa/Linux.db "UPDATE sql SET versionID = $number WHERE versionID < $number"
fi
done <"$file"
