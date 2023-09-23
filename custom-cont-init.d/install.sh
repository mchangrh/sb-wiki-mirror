#!/bin/sh
cd /app/www/public || exit
# check if dump exists
DUMP_PATH=/app/dump.xml.gz
if [ ! -f ${DUMP_PATH} ]; then
    echo "Dump not found, downloading..."
    wget https://wiki.sponsor.ajay.app/images/sponsorblock_wiki_current_revisions.xml.gz -O /tmp/dump.xml.gz
    DUMP_PATH=/tmp/dump.xml.gz
fi
# import and rebuild
php maintenance/install.php --confpath="/app/www/public" --dbname=mediawiki --dbtype=mysql --dbuser=mediawiki --dbpass="sponsor.ajay.app/donate" --dbserver=mariadb --server="http://localhost:8080" --scriptpath="" --lang=en --pass=sponsor.ajay.app/donate "SponsorBlock" Admin
cp /app/LocalSettings.php /app/www/public/LocalSettings.php
echo "Main_Page" >> /app/delete_pages.txt
php maintenance/deleteBatch.php /app/delete_pages.txt
php maintenance/importDump.php "${DUMP_PATH}"
php maintenance/runJobs.php