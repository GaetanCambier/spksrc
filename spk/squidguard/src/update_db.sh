#!/bin/sh

PACKAGE="squidguard"
INSTALL_DIR="/usr/local/${PACKAGE}"
DB_DIR="${INSTALL_DIR}/var/db"
SQUID_CONF_DIR="${INSTALL_DIR}/etc"
FILTER_ADBLOCK_DIR="${DB_DIR}/adblock"
RSYNC_DIR="rsync://ftp.ut-capitole.fr/blacklist/dest/"

strip_file_header() { 
	grep -v '^$\|^#' "$1" | sed 's/$/ /' | tr -d '\n'
}

ADBLOCK_PATTERNS=$(strip_file_header "${SQUID_CONF_DIR}/adblock.sed")
EASYLIST_TMP_DIR="/tmp/adblock"
EASYLIST_URL_LIST=$(strip_file_header "${SQUID_CONF_DIR}/adblock.conf")

mkdir -p "${FILTER_ADBLOCK_DIR}"
mkdir -p ${EASYLIST_TMP_DIR}

echo \ > "${FILTER_ADBLOCK_DIR}/expressions"
for URL in ${EASYLIST_URL_LIST}
do
	wget --timeout=15 -q --no-check-certificate -P ${EASYLIST_TMP_DIR} "${URL}"
	LIST_FILE_PATH="${EASYLIST_TMP_DIR}/$(basename "${URL}")"
	LIST_FILE_NAME="$(basename "${LIST_FILE_PATH}" .txt)"
	grep -q -E '^\[Adblock.*\]$' "${LIST_FILE_PATH}"
	if [ $? -eq 0 ] ; then
		sed -e "${ADBLOCK_PATTERNS}" "${LIST_FILE_PATH}" >> "${FILTER_ADBLOCK_DIR}/expressions"
	fi
done
rm -rf ${EASYLIST_TMP_DIR} > /dev/null 2>&1

rsync -a ${RSYNC_DIR} ${DB_DIR}
if [ $? -eq 0 ]
then
    ${INSTALL_DIR}/bin/squidGuard -P -c ${INSTALL_DIR}/etc/squidguard.conf -C all
fi
chown -R nobody:nobody ${DB_DIR}
