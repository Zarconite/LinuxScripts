#!/bin/bash
sqlite3 /home/adminsa/Linux.db "UPDATE sql SET versionID = 0"
rm /home/adminsa/BuiltDB.db
rm /home/adminsa/DBBLog.txt
rm /home/adminsa/DBBoutput.txt
mv /home/adminsa/DatabaseBuilderArchive/* /home/adminsa/DatabaseBuilder/

