#!/bin/sh

# Package
PACKAGE="squidguard"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}"
PATH="${INSTALL_DIR}/bin:/usr/local/bin:/bin:/usr/bin:/usr/syno/bin"
RUNAS="squid"
DB_DIR="${INSTALL_DIR}/var/db"
RSYNC_DIR="rsync://ftp.ut-capitole.fr/blacklist/dest/"

cd ${DB_DIR}
rsync -arpogvt ${RSYNC_DIR} .
if [ $? -eq 0 ]
then
    chown -R ${RUNAS}:root ${DB_DIR}
    if [ ${SYNOPKG_DSM_VERSION_MAJOR} -lt "6" ];
    then
        su - ${RUNAS} -c "${INSTALL_DIR}/bin/squidGuard -c ${INSTALL_DIR}/etc/squidguard.conf -C all"
    else
        sudo -u ${RUNAS} ${INSTALL_DIR}/bin/squidGuard -c ${INSTALL_DIR}/etc/squidguard.conf -C all
    fi
fi
