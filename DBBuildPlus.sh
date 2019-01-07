#!/bin/bash
ls /home/adminsa/DatabaseBuilder | grep -v -i '^[a-z]' | grep .sql | sort -g | tee DBBoutput.txt
file="/home/adminsa/DBBoutput.txt"
touch DBBLog.txt
while IFS= read -r line
do
number=$(echo "$line" | sed 's/^[^0-9]*//;s/[^0-9].*$//')
current=$(sqlite3 /home/adminsa/Linux.db "SELECT versionID FROM sql")
if [ "$current" -lt "$number" ]
then
sqlite3 /home/adminsa/BuiltDB.db < /home/adminsa/DatabaseBuilder/$line
echo "Executed: $line, with script: $(cat /home/adminsa/DatabaseBuilder/$line)" >> /home/adminsa/DBBLog.txt
sqlite3 /home/adminsa/Linux.db "UPDATE sql SET versionID = $number WHERE versionID < $number"
mv /home/adminsa/DatabaseBuilder/$line /home/adminsa/DatabaseBuilderArchive/
else
echo "File: $line has already been executed, Skipping!" >> /home/adminsa/DBBLog.txt
fi
done <"$file"
