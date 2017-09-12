#!/bin/bash

while getopts ":f:b:" opt
do
    case $opt in
        f)
            folder=${OPTARG}
            ;;
        b)
            database=${OPTARG}
            ;;
        *)
           echo "Run script: ./task3.sh -f site_folder_name -b database_name" >&2
           exit 1
           ;;
    esac
done

if [ -z "$folder" ] || [ -z "$database" ]
then
    echo "Run script: ./task3.sh -f site_folder_name -b database_name" >&2
    exit 1
fi

echo "folder: $folder and database: $database"

date=$(date +%Y-%m-%d)
remove_days=14

for file in $(ls -lah --full-time *.tar.gz *.sql | awk {'print $9'})
do
    dates=$(ls -lah --full-time $file | awk '{print $6}')
    difference=$(( ( $(date -ud $date +'%s') - $(date -ud $dates +'%s') )/60/60/24 ))
   if [ $difference -gt $remove_days ]
   then
        echo "file if old"
    fi
done


tar -czvf $folder-$date.tar.gz /var/www/$folder
mysqldump -u root $database > $database-$date.sql
