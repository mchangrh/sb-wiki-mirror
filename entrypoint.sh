#!/bin/sh
DUMP_NAME=dump.xml.gz
cd /var/www/html || exit
# import and rebuild
php maintenance/install.php --confpath="/var/www/html" --dbname=mediawiki --dbtype=mysql --dbuser=mediawiki --dbpass="sponsor.ajay.app/donate" --dbserver=mariadb --server="http://localhost:8080" --scriptpath="" --lang=en --pass=sponsor.ajay.app/donate "SponsorBlock" Admin
cp /app/LocalSettings.php /var/www/html/LocalSettings.php
echo "Main_Page" >> /app/delete_pages.txt
php maintenance/deleteBatch.php /app/delete_pages.txt
php maintenance/importDump.php /app/"${DUMP_NAME}"
php maintenance/runJobs.php
# start server
apache2-foreground