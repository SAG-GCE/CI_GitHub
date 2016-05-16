#!/bin/sh

#
# Copyright (c) 1996-2007, webMethods Inc.  All Rights Reserved.
# setcp.bat: Set CLASSPATH to run TN utils.  This file is called
# by the other batch scripts in this directory to configure the
# environment for connecting to the TN data store.
#
# Change SERVDIR and JDKDIR to reflect their locations on your system
#

# --- LOCATION OF WEBMETHODS B2B SERVER ---
DIRNAME=`pwd`

INSTANCEDIR=`cd "$DIRNAME/../../.."; pwd`
INSTALLDIR=`cd "$DIRNAME/../../../../../.."; pwd`
SERVDIR=${INSTALLDIR}/IntegrationServer
COMMONDIR=${INSTALLDIR}/common

. ${INSTALLDIR}/install/bin/setenv.sh

#--LOCATION OF COMMON LIB JARS--
WEBMEXT=${COMMONDIR}/lib/ext

# ================================================================
# IF YOU WOULD LIKE TO ADD YOUR OWN FILES TO THE CLASSPATH
# THEN SET THE FOLLOWING LINE TO CONTAIN YOUR CLASSPATH ADDITIONS
#         Example:  SET ADDCLASSES=C:\myclasses\joe.jar
# ================================================================
ADDCLASSES=

# --- SET THE FOLLOWING LINE TO "java" AND MODIFY JDKDIR TO POINT ---
# --- TO YOUR SUN JDK TO RUN WITH Java 1.2                        ---
JDKDIR=${JRE_HOME}

SSL_DIR=${WEBMEXT}

SSL_PATH=${SSL_DIR}/enttoolkit.jar

# --- UPDATE PATH AND SET INITIAL CLASSPATH ---
PATH=${PATH}:${SERVDIR}/bin:${SERVDIR}/packages/WmTN/bin:${JDKDIR}/bin
CLASSPATH=${SERVDIR}/lib/classes:${SERVDIR}/lib/wm-isserver.jar:${COMMONDIR}/lib/wm-isclient.jar:${COMMONDIR}/lib/wm-scg-audit.jar:${COMMONDIR}/lib/wm-g11nutils.jar:${COMMONDIR}/lib/wm-scg-security.jar:${COMMONDIR}/lib/wm-scg-core.jar:${COMMONDIR}/lib/wm-acdl-common.jar:${COMMONDIR}/lib/ext/jdom.jar:${COMMONDIR}/lib/glassfish/gf.javax.mail.jar:${WEBMEXT}/icu4j.jar:${WEBMEXT}/dd-cjdbc.jar:${SERVDIR}/lib/server.zip:.:${SERVDIR}/lib/jdk11x_update.jar:${JDKDIR}/lib/rt.jar:${JDKDIR}/lib/i18n.jar:${SERVDIR}/lib/classes:${ADDCLASSES}:${SSL_PATH}:${COMMONDIR}/lib/ehcache-ee.jar:${COMMONDIR}/lib/terracotta-toolkit-runtime-ee.jar:${COMMONDIR}/lib/ext/slf4j-api.jar:${COMMONDIR}/lib/ext/slf4j-log4j.jar:${COMMONDIR}/lib/ext/log4j.jar:${COMMONDIR}/lib/ext/commons-codec.jar:${COMMONDIR}/lib/ext/bam-jms-util.jar

# ================================================================
# Update CLASSPATH to include all jar and zip files in lib/jars
# of the B2B server
# ================================================================
if [ -d ${SERVDIR}/lib/jars ]; then
  jardir=${SERVDIR}/lib/jars
  for jar in `/bin/ls ${jardir}/*.jar ${jardir}/*.zip 2>/dev/null`
  do
    CLASSPATH=${CLASSPATH}:$jar
  done
fi


# ================================================================
# Update CLASSPATH to include all jar and zip files in WmTN/code/jars
# ================================================================
if [ -d ${INSTANCEDIR}/packages/WmTN/code/jars ]; then
  jardir=${INSTANCEDIR}/packages/WmTN/code/jars
  for jar in `/bin/ls ${jardir}/*.jar ${jardir}/*.zip 2>/dev/null`
  do
    CLASSPATH=${CLASSPATH}:$jar
  done
fi

# ================================================================
# Update CLASSPATH to include all jar and zip files in WmTN/code/jars/static
# ================================================================
if [ -d ${INSTANCEDIR}/packages/WmTN/code/jars/static ]; then
  jardir=${INSTANCEDIR}/packages/WmTN/code/jars/static
  for jar in `/bin/ls ${jardir}/*.jar ${jardir}/*.zip 2>/dev/null`
  do
    CLASSPATH=${CLASSPATH}:$jar
  done
fi

# =================================================================
# Update CLASSPATH to include ffcore.jar, editn.jar and ediintdoc.jar for EDI documenttypes
# =================================================================
if [ -f ${INSTANCEDIR}/packages/WmFlatFile/code/jars/static/ffcore.jar ]; then  
    CLASSPATH=${CLASSPATH}:${INSTANCEDIR}/packages/WmFlatFile/code/jars/static/ffcore.jar  
fi

if [ -f ${INSTANCEDIR}/packages/WmEDIforTN/code/jars/static/editn.jar ]; then  
    CLASSPATH=${CLASSPATH}:${INSTANCEDIR}/packages/WmEDIforTN/code/jars/static/editn.jar  
fi

if [ -f ${INSTANCEDIR}/packages/WmEDIINT/code/jars/static/ediintdoc.jar ]; then 
    CLASSPATH=${CLASSPATH}:${INSTANCEDIR}/packages/WmEDIINT/code/jars/static/ediintdoc.jar 
fi 
