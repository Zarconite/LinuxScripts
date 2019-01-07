#!/bin/bash
ls /home/adminsa/folder | grep -v -i '^[a-z]' | grep .sql | sort -g | sed 's/^[^0-9]*//;s/[^0-9].*$//' | tee output.txt

file="/home/adminsa/output.txt"
while IFS= read -r line
do
sqlite3 /home/adminsa/Linux.db "UPDATE sql SET versionID = $line WHERE versionID < $line"
done <"$file"
