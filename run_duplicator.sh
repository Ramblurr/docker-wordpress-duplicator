#!/bin/bash

if [ -f /duplicator/installer.php ]; then
    if test -n "$(find /duplicator -maxdepth 1 -type f -name '*.zip' -print -quit)"; then

        now=$(date +"%Y%m%d_%H%M%S")
        mv /duplicator/installer.php /app
        echo "=> Moved /duplicator/installer.php"
        mv /duplicator/*.zip /app
        echo "=> Moved /duplicator/*zip"

        if [ -f /duplicator/wp-config.php ]; then
            mv /app/wp-config.php /app/wp-config.${now}.bak
            echo "=> Backed up existing /app/wp-config.php to /app/wp-config.${now}.bak"
        fi

        sed -i.bak \
            -e "s/^\(\$GLOBALS\['FW_DBHOST'\] = \).*;/\1getenv('DB_HOST') . ':' . getenv('DB_PORT');/" \
            -e "s/^\(\$GLOBALS\['FW_DBUSER'\] = \).*;/\1getenv('DATA_DB_USER');/" \
            -e "s/^\(\$GLOBALS\['FW_DBPASS'\] = \).*;/\1getenv('DATA_DB_PASS');/" \
            -e "s/^\$_POST\['dbhost'\]\s*=\s*isset(\$_POST\['dbhost'\]) ? trim(\$_POST\['dbhost'\]) : null;/\$_POST\['dbhost'\] = isset(\$_POST\['dbhost'\]) ? parse_url(trim(\$_POST\['dbhost'\]), PHP_URL_HOST ) : null;/" \
            /app/installer.php

        chown -R www-data:www-data /app/installer.php
        chown -R www-data:www-data /app/*.zip

    else
        echo "=> ERROR:  Found /duplicator/installer.php, but no data package .zip"
        exit 1
    fi
fi

exec /run_wordpress.sh

