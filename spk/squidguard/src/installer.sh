#!/bin/sh

# Package
PACKAGE="squidguard"
DNAME="SquidGuard"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}"
VAR_DIR="${INSTALL_DIR}/var"
DB_DIR="${VAR_DIR}/db"
SQUID="${INSTALL_DIR}/sbin/squid"
ETC_DIR="${INSTALL_DIR}/etc"
CFG_FILE="${ETC_DIR}/squid.conf"
WWW_DIR="/var/packages/${PACKAGE}/target/share/www/squidguardmgr"
SERVICETOOL="/usr/syno/bin/servicetool"
FWPORTS="/var/packages/${PACKAGE}/scripts/${PACKAGE}.sc"
TMP_DIR="${SYNOPKG_PKGDEST}/../../@tmp/${PACKAGE}"

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
    rm -fr ${TMP_DIR}
    mkdir -p ${TMP_DIR}/etc
    mkdir -p ${TMP_DIR}/var/cache
    mkdir -p ${TMP_DIR}/var/db
    mkdir -p ${TMP_DIR}/var/logs
    mkdir -p ${TMP_DIR}/var/ssl_db
    mv ${ETC_DIR}/squidguard.conf ${TMP_DIR}/etc/
    mv ${ETC_DIR}/squid.conf ${TMP_DIR}/etc/
    mv ${ETC_DIR}/squidclamav.conf ${TMP_DIR}/etc/
    mv ${ETC_DIR}/adblock.conf ${TMP_DIR}/etc/
    mv ${VAR_DIR}/cache ${TMP_DIR}/var/
    mv ${DB_DIR} ${TMP_DIR}/var/
    mv ${VAR_DIR}/logs ${TMP_DIR}/var/
    mv ${VAR_DIR}/ssl_db ${TMP_DIR}/var/
    exit 0
}

postupgrade ()
{
    # Restore some stuff
    mv -f ${TMP_DIR}/etc/* ${ETC_DIR}/
    rm -Rf ${VAR_DIR}/cache/*
    mv -f ${TMP_DIR}/var/cache/* ${VAR_DIR}/cache/
    rm -Rf ${DB_DIR}/*
    mv -f ${TMP_DIR}/var/db/* ${DB_DIR}/
    rm -Rf ${VAR_DIR}/ssl_db/*
    mv -f ${TMP_DIR}/var/ssl_db/* ${VAR_DIR}/ssl_db/
    rm -Rf ${VAR_DIR}/logs/*
    mv -f ${TMP_DIR}/var/logs/* ${VAR_DIR}/logs/
    rm -Rf ${TMP_DIR}
    
    chown -R root:nobody ${SYNOPKG_PKGDEST}
    chmod g+w ${SYNOPKG_PKGDEST}
    chmod -R g+w ${VAR_DIR}
    chown -R nobody:nobody ${DB_DIR}

    # check squid.conf and restore default file if parse error
    ${SQUID} -f ${CFG_FILE} -k parse &> /dev/null
    if [ $? -ne 0 ]; then
        mv -f ${CFG_FILE} ${CFG_FILE}.bad
        cp ${CFG_FILE}.default ${CFG_FILE}
    fi
    exit 0
}
