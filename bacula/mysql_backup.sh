#!/bin/bash
USER=root
PASSWORD="password"
# DATE=`date +"%Y-%m-%d"`
# mkdir -p /var/backups/mysql/${DATE}
cd /var/backups/mariadb/
# cd ${DATE}
DBS=`echo "show databases;" | /usr/bin/mysql -s -u${USER} -p${PASSWORD}`
for DBNAME in $DBS; do
echo Backing up $DBNAME...
    /usr/bin/mysqldump \
        --add-drop-database --add-drop-table \
        --complete-insert --create-options \
        --single-transaction -u${USER} -p${PASSWORD} \
        ${DBNAME} > ${DBNAME}.sql
done
echo Compressing files
rm *.sql.gz 2> /dev/null
gzip -9v *.sql
echo DONE
