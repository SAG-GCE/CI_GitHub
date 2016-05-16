#!/bin/sh

#
# Copyright (c) 1996-2007, webMethods Inc.  All Rights Reserved.
#

. ./setcp.sh

cd ../../../

${JDKDIR}/bin/java -ms64M -mx64M -classpath ${CLASSPATH} com.wm.app.tn.data.Import ${INSTANCEDIR} "$@"

