FROM ghcr.io/mchangrh/sb-wiki:1.39
# add configs
ADD sb-wiki/mediawiki/sb-wikilogo.tar.gz /config/mediawiki/images/

COPY sb-wiki/mediawiki/settings/includes /includes
COPY settings/secrets /secrets
COPY settings/overrides /includes
COPY custom-cont-init.d /custom-cont-init.d