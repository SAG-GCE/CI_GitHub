#!/bin/sh

#
# Copyright (c) 1996-2007, webMethods Inc.  All Rights Reserved.
# setcp.bat: Set CLASSPATH to run TN utils
#

. ./setcp.sh

cd ../../../

${JDKDIR}/bin/java -ms64M -mx64M -classpath ${CLASSPATH} com.wm.app.tn.db.QueryTest ${INSTANCEDIR} "$@"
