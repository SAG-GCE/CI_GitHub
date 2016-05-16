@echo off

rem
rem Copyright (c) 1996-2007, webMethods Inc.  All Rights Reserved.
rem setcp.bat: Set CLASSPATH to run TN utils
rem
rem Change SERVDIR and JDKDIR to reflect their locations on your system
rem 
rem To run the B2B Integration Server on a Java 1.2 VM, you will have to
rem make some additional modifications:
rem
rem (1) Change the JDKDIR to reflect the location of your Java 1.2 VM.
rem
rem (2) If you are using the 1.2 JDK from Sun:
rem
rem     Remove the %JDKDIR%\LIB\RT.JAR entry in the CLASSPATH on line
rem     96.  It is no longer necessary to identify the system classes
rem     for the JVM.  (The CLASSPATH should start with
rem     "%SERVDIR%\lib\jdk11x_update.jar")
rem
rem     Set line 51 to be:
rem         SET SUNCMD=java
rem
rem

SETLOCAL
CALL setcp
SET JITC_COMPILEOPT=SKIP{com/wm/util/coder/RPCBinCoder2}{_encode}

cd ..\..\..\

if %USEJVIEW%==true goto jview
SET SCMD="%JDKDIR%\bin\%SUNCMD%" -ms64M -mx64M -classpath %CLASSPATH% com.wm.app.tn.db.QueryTest "%INSTANCEDIR%" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto launch

:jview
SET SCMD=jview /cp %CLASSPATH% com.wm.app.tn.db.QueryTest "%INSTANCEDIR%" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto launch

:launch
%SCMD%

:done

ENDLOCAL
