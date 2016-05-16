@echo off

rem
rem Copyright (c) 1996-2007, webMethods Inc.  All Rights Reserved.
rem setcp.bat: Set CLASSPATH to run TN utils
rem
rem Do not modify this file -- edit setcp.bat to reflect your JVM
rem preferences
rem 

SETLOCAL
CALL setcp
SET JITC_COMPILEOPT=SKIP{com/wm/util/coder/RPCBinCoder2}{_encode}

cd ..\..\..\

if %USEJVIEW%==true goto jview
SET SCMD="%JDKDIR%\bin\%SUNCMD%" -ms64M -mx64M -classpath %CLASSPATH% com.wm.app.tn.data.Import "%INSTANCEDIR%" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto launch

:jview
SET SCMD=jview /cp %CLASSPATH% com.wm.app.tn.data.Import "%INSTANCEDIR%" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto launch

:launch
%SCMD%

:done

ENDLOCAL
