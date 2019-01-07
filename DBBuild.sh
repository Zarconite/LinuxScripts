#!/bin/bash
ls /home/adminsa/DatabaseBuilder | grep -v -i '^[a-z]' | grep .sql | sort -g | tee DBBoutput.txt
file="/home/adminsa/DBBoutput.txt"
while IFS= read -r line
do
number=$(echo "$line" | sed 's/^[^0-9]*//;s/[^0-9].*$//')
current=$(sqlite3 /home/adminsa/Linux.db "SELECT versionID FROM sql")
if [ "$current" -lt "$number" ]
then
sqlite3 /home/adminsa/BuiltDB.db < /home/adminsa/DatabaseBuilder/$line
sqlite3 /home/adminsa/Linux.db "UPDATE sql SET versionID = $number WHERE versionID < $number"
fi
done <"$file"
