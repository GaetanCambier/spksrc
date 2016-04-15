#!/bin/sh

# Package
PACKAGE="squidguard"
DNAME="SquidGuard"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}"
PATH="${INSTALL_DIR}/bin:/usr/local/bin:/bin:/usr/bin:/usr/syno/bin"
DB_DIR="${INSTALL_DIR}/var/db"
SQUID="${INSTALL_DIR}/sbin/squid"
CFG_FILE="${INSTALL_DIR}/etc/squid.conf"
ETC_DIR="${INSTALL_DIR}/etc/"
WWW_DIR="/var/packages/${PACKAGE}/target/share/www/squidguardmgr"
WEBMAN_DIR="/usr/syno/synoman/webman/3rdparty"
SQUID_WRAPPER="${WWW_DIR}/squid_wrapper"
SERVICETOOL="/usr/syno/bin/servicetool"
FWPORTS="/var/packages/${PACKAGE}/scripts/${PACKAGE}.sc"
TMP_DIR="${SYNOPKG_PKGDEST}/../../@tmp"

preinst ()
{
    exit 0
}

postinst ()
{
    # Link
    ln -s ${SYNOPKG_PKGDEST} ${INSTALL_DIR}
    ln -s ${WWW_DIR} ${INSTALL_DIR}/ui

    # Install busybox stuff
    ${INSTALL_DIR}/bin/busybox --install ${INSTALL_DIR}/bin

    # Patch template files
    hostname=`hostname`
    sed "s/==HOSTNAME==/$hostname/g" ${ETC_DIR}/squidguard.conf.tpl > ${ETC_DIR}/squidguard.conf
    sed "s/==HOSTNAME==/$hostname/g" ${ETC_DIR}/squidclamav.conf.tpl > ${ETC_DIR}/squidclamav.conf    
    if [ "${SYNOPKG_PKG_STATUS}" == "INSTALL" ]; then
        # Init squid cache directory
        ${SQUID} -z -f ${CFG_FILE}
        # launch first the update
        ${INSTALL_DIR}/bin/update_db.sh > ${INSTALL_DIR}/var/logs/update_db.log 2>&1 &
        chown -R root:nobody ${SYNOPKG_PKGDEST}/
        chmod g+w ${SYNOPKG_PKGDEST}
        chmod -R g+w ${SYNOPKG_PKGDEST}/var
        chown -R nobody:nobody ${DB_DIR}
    fi
    # Init SSLBump cache directory
    ${INSTALL_DIR}/libexec/ssl_crtd -c -s ${INSTALL_DIR}/var/ssl_db >> /dev/null
    ln -sf ${INSTALL_DIR}/etc/squidguardmgr.conf ${INSTALL_DIR}/share/www/squidguardmgr/squidguardmgr.conf

    # For squidclamav redirect
    ln -sf ${INSTALL_DIR}/libexec/squidclamav/clwarn.cgi ${INSTALL_DIR}/share/www/squidguardmgr/clwarn.cgi
    # Init crontab :
    #    update squidguard DB each day at 1 a.m
    #    logs rotate every sunday at 0:15 a.a
    grep ${PACKAGE} /etc/crontab
    if [ $? -eq 1 ]; then
        echo "0	1	*	*	*	root	${INSTALL_DIR}/bin/update_db.sh > ${INSTALL_DIR}/var/logs/update_db.log" >> /etc/crontab
        echo "15	0	*	*	0	root	${INSTALL_DIR}/bin/logrotate.sh > ${INSTALL_DIR}/bin/logrotate.log" >> /etc/crontab
        /usr/syno/sbin/synoservicecfg --restart crond
    fi
    # Add firewall config
    ${SERVICETOOL} --install-configure-file --package ${FWPORTS} >> /dev/null

    exit 0
}

preuninst ()
{
    # Remove firewall config
    if [ "${SYNOPKG_PKG_STATUS}" == "UNINSTALL" ]; then
        ${SERVICETOOL} --remove-configure-file --package ${FWPORTS} >> /dev/null
    fi

    exit 0
}

postuninst ()
{
    # Remove link
    rm -f ${INSTALL_DIR}
    sed "/${PACKAGE}/d" /etc/crontab >> /dev/null
    /usr/syno/sbin/synoservicecfg --restart crond
    
    exit 0
}

preupgrade ()
{
    # Save some stuff
    rm -fr ${TMP_DIR}/${PACKAGE}
    mkdir -p ${TMP_DIR}/${PACKAGE}/etc
    mkdir -p ${TMP_DIR}/${PACKAGE}/var/cache
    mkdir -p ${TMP_DIR}/${PACKAGE}/var/db
    mkdir -p ${TMP_DIR}/${PACKAGE}/var/logs
    mkdir -p ${TMP_DIR}/${PACKAGE}/var/ssl_db
    mv ${INSTALL_DIR}/etc/squidguard.conf ${TMP_DIR}/${PACKAGE}/etc/
    mv ${INSTALL_DIR}/etc/squid.conf ${TMP_DIR}/${PACKAGE}/etc/
    mv ${INSTALL_DIR}/etc/squidclamav.conf ${TMP_DIR}/${PACKAGE}/etc/
    mv ${INSTALL_DIR}/etc/adblock.conf ${TMP_DIR}/${PACKAGE}/etc/
    mv ${INSTALL_DIR}/var/cache ${TMP_DIR}/${PACKAGE}/var/
    mv ${INSTALL_DIR}/var/db ${TMP_DIR}/${PACKAGE}/var/
    mv ${INSTALL_DIR}/var/logs ${TMP_DIR}/${PACKAGE}/var/
    mv ${INSTALL_DIR}/var/ssl_db ${TMP_DIR}/${PACKAGE}/var/
    exit 0
}

postupgrade ()
{
    # Restore some stuff
    mv -f ${TMP_DIR}/${PACKAGE}/etc/* ${INSTALL_DIR}/etc/
    rm -Rf ${INSTALL_DIR}/var/cache/*
    mv -f ${TMP_DIR}/${PACKAGE}/var/cache/* ${INSTALL_DIR}/var/cache/
    rm -Rf ${INSTALL_DIR}/var/db/*
    mv -f ${TMP_DIR}/${PACKAGE}/var/db/* ${INSTALL_DIR}/var/db/
    rm -Rf ${INSTALL_DIR}/var/ssl_db/*
    mv -f ${TMP_DIR}/${PACKAGE}/var/ssl_db/* ${INSTALL_DIR}/var/ssl_db/
    rm -Rf ${INSTALL_DIR}/var/logs/*
    mv -f ${TMP_DIR}/${PACKAGE}/var/logs/* ${INSTALL_DIR}/var/logs/
    rm -Rf ${TMP_DIR}/${PACKAGE}
    
    chown -R root:nobody ${SYNOPKG_PKGDEST}/
    chmod g+w ${SYNOPKG_PKGDEST}
    chmod -R g+w ${SYNOPKG_PKGDEST}/var
    chown -R nobody:nobody ${DB_DIR}

    # check squid.conf and restore default file if parse error
    ${SQUID} -f ${CFG_FILE} -k parse &> /dev/null
    if [ $? -ne 0 ]; then
        mv -f ${CFG_FILE} ${CFG_FILE}.bad
        cp ${CFG_FILE}.default ${CFG_FILE}
    fi
    exit 0
}
