#!/bin/sh

#
# Copyright (c) 1996-2005, webMethods Inc.  All Rights Reserved.
# setcp.sh: Set CLASSPATH to run TN utils
#
# Do not modify this file -- edit packages\WmTN\bin\setcp.sh to reflect your JVM
# preferences
#

. ../../../bin/setcp.sh

SRCSERVER=$1

CLASSPATH=${CLASSPATH}:${SRCSERVER}/lib/jars/cs_cloudscape.jar:${SRCSERVER}/lib/jars/cs_tools.jar:${SRCSERVER}/lib/jars/cs_license.jar:${SRCSERVER}/packages/WmTN/code/jars/static/cs_cloudscape.jar:${SRCSERVER}/packages/WmTN/code/jars/static/cs_tools.jar

CSDB_LOCATION=${SRCSERVER}/packages/WmTN/data/TradingNetworks

${JDKDIR}/bin/java -ms196M -mx512M -classpath ${CLASSPATH} -Djava.compiler=NONE -Ddbtransfer.cloudscape.location=${CSDB_LOCATION} com.wm.app.tn.util.dbtransfer.DBTransfer ${SRCSERVER}
