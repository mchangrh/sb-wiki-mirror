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
php maintenance/run.php install --confpath="/app/www/public" --dbname=mediawiki --dbtype=mysql --dbuser=mediawiki --dbpass="sponsor.ajay.app/donate" --dbserver=mariadb --server="http://localhost:8080" --scriptpath="" --lang=en --pass=sponsor.ajay.app/donate "SponsorBlock" Admin
cp /app/LocalSettings.php /app/www/public/LocalSettings.php
echo "*** Importing dump ***"
echo "Main_Page" >> /app/delete_pages.txt
php maintenance/run.php deleteBatch /app/delete_pages.txt
php maintenance/run.php importDump "${DUMP_PATH}"
php maintenance/run.php runJobs
php maintenance/run.php update --quick
echo "*** MediaWiki installed and ready ***"