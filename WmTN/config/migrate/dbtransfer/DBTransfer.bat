@echo off

rem
rem Copyright (c) 1996-2005, webMethods Inc.  All Rights Reserved.
rem setcp.bat: Set CLASSPATH to run TN utils
rem
rem Do not modify this file -- edit packages\WmTN\bin\setcp.bat to reflect your JVM
rem preferences
rem

SETLOCAL
CALL ..\..\..\bin\setcp

SET SRCSERVER=%1

SET CLASSPATH=%CLASSPATH%;%SRCSERVER%\lib\jars\cs_cloudscape.jar;%SRCSERVER%\lib\jars\cs_tools.jar;%SRCSERVER%\lib\jars\cs_license.jar;%SRCSERVER%\packages\WmTN\code\jars\static\cs_cloudscape.jar;%SRCSERVER%\packages\WmTN\code\jars\static\cs_tools.jar

SET CSDB_LOCATION=%SRCSERVER%\packages\WmTN\data\TradingNetworks

if %USEJVIEW%==true goto jview
SET SCMD="%JDKDIR%\bin\%SUNCMD%" -ms196M -mx512M -classpath %CLASSPATH% -Djava.compiler=NONE -Ddbtransfer.cloudscape.location="%CSDB_LOCATION%" com.wm.app.tn.util.dbtransfer.DBTransfer "%SRCSERVER%"
goto launch

:jview
SET SCMD=jview /cp %CLASSPATH% com.wm.app.tn.util.dbtransfer.DBTransfer "%SERVDIR%"
goto launch

:launch
%SCMD%

:done

ENDLOCAL
