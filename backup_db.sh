#!/bin/sh

# List Databases to Dump
 DBS="$(mysql -u root -ppassword -Bse 'show databases')"
 for db in $DBS
  do
   DMPFILE="$db"_$(date +"%Y%m%d").dmp
   BACKUPFILE="$db"_$(date +"%Y%m%d").7z

   # Dump Database
   mysqldump -u root -ppassword $db > $DMPFILE

   # Zip Dump
   7za a $BACKUPFILE $DMPFILE

   # Upload Zip
   MONTH=$(date +"%Y%m")
   sudo s3cmd put $BACKUPFILE s3://backet/$MONTH/$DMPFILE

   # Delete Local Dump and Zip
   sudo rm $DMPFILE $BACKUPFILE
  done