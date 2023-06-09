FROM ghcr.io/mchangrh/sb-wiki:1.39
# add configs
ADD sb-wiki/mediawiki/sb-wikilogo.tar.gz /var/www/html/images

COPY sb-wiki/mediawiki/settings/includes /includes
COPY settings/secrets /secrets
COPY settings/overrides /includes
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]