rem @echo off

rem
rem Copyright (c) 1996-2007, webMethods Inc.  All Rights Reserved.
rem setcp.bat: Set CLASSPATH to run TN utils.  This file is called
rem by the other batch scripts in this directory to configure the
rem environment for connecting to the TN data store.
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
rem     53.  It is no longer necessary to identify the system classes
rem     for the JVM.  (The CLASSPATH should start with
rem     "%SERVDIR%\lib\jdk11x_update.jar")
rem
rem     Set line 47 to be:
rem         SET SUNCMD=java
rem
rem

rem --- LOCATION OF WEBMETHODS B2B SERVER ---

SET DIRNAME=%~dp0

pushd .
cd /D "%DIRNAME%\..\..\.."
SET INSTANCEDIR=%CD%
popd

pushd .
cd /D "%DIRNAME%\..\..\..\..\..\.."
SET INSTALLDIR=%CD%
popd

SET SERVDIR=%INSTALLDIR%\IntegrationServer
SET COMMONDIR=%INSTALLDIR%\common

call "%INSTALLDIR%\install\bin\setenv.bat"

rem --- LOCATION OF WEBMETHODS COMMON/LIB/EXT--

SET WEBMEXT=%COMMONDIR%\lib\ext

rem ================================================================
rem IF YOU WOULD LIKE TO ADD YOUR OWN FILES TO THE CLASSPATH
rem THEN SET THE FOLLOWING LINE TO CONTAIN YOUR CLASSPATH ADDITIONS
rem         Example:  SET ADDCLASSES=C:\myclasses\joe.jar
rem ================================================================
SET ADDCLASSES=

rem --- SET THE FOLLOWING LINE TO "true" TO RUN WITH jview ---
SET USEJVIEW=false

rem --- SET THE FOLLOWING LINE TO "java" AND MODIFY JDKDIR TO POINT ---
rem --- TO YOUR SUN JDK TO RUN WITH Java 1.2                        ---
SET JDKDIR=%JRE_HOME%
SET SUNCMD=jre

if exist "%JDKDIR%\bin\java.exe" (
    SET SUNCMD=java
)

SET SSL_DIR=%WEBMEXT%

SET SSL_PATH=%SSL_DIR%\enttoolkit.jar

rem --- UPDATE PATH AND SET INITIAL CLASSPATH ---
SET PATH=%PATH%;"%SERVDIR%\lib"
SET CLASSPATH="%SERVDIR%\lib\classes";"%SERVDIR%\lib\wm-isserver.jar";"%COMMONDIR%\lib\wm-isclient.jar";"%COMMONDIR%\lib\wm-scg-audit.jar";"%COMMONDIR%\lib\wm-g11nutils.jar";"%COMMONDIR%\lib\wm-scg-security.jar";"%COMMONDIR%\lib\wm-scg-core.jar";"%COMMONDIR%\lib\wm-acdl-common.jar";"%COMMONDIR%\lib\ext\jdom.jar";"%COMMONDIR%\lib\glassfish\gf.javax.mail.jar";"%WEBMEXT%\icu4j.jar";"%WEBMEXT%\dd-cjdbc.jar";"%SERVDIR%\lib\server.zip";.;"%SSL_PATH%";"%COMMONDIR%\lib\ehcache-ee.jar";"%COMMONDIR%\lib\terracotta-toolkit-runtime-ee.jar";"%COMMONDIR%\lib\ext\slf4j-api.jar";"%COMMONDIR%\lib\ext\slf4j-log4j.jar";"%COMMONDIR%\lib\ext\log4j.jar";"%COMMONDIR%\lib\ext\commons-codec.jar";"%COMMONDIR%\lib\bam-jms-util.jar";
if %USEJVIEW%==false SET CLASSPATH=%CLASSPATH%;"%SERVDIR%\lib\jdk11x_update.jar";"%JDKDIR%\LIB\RT.JAR";"%JDKDIR%\lib\i18n.jar";"%SERVDIR%\lib\classes"
if %USEJVIEW%==true SET CLASSPATH=%CLASSPATH%;"%SERVDIR%\lib\classes"

rem ================================================================
rem Update CLASSPATH to include all jar and zip files in lib\jars
rem of the B2B server
rem ================================================================
if exist "%SERVDIR%\lib\jars" (
    call :appendJarsAndZips "%SERVDIR%\lib\jars"
)

rem ================================================================
rem Update CLASSPATH to include all jar and zip files in WmTN\code\jars
rem ================================================================
if exist "%INSTANCEDIR%\packages\WmTN\code\jars" (
    call :appendJarsAndZips "%INSTANCEDIR%\packages\WmTN\code\jars"
)


rem ================================================================
rem Update CLASSPATH to include all jar and zip files in WmTN\code\jars\static
rem ================================================================
if exist "%INSTANCEDIR%\packages\WmTN\code\jars\static" (
    call :appendJarsAndZips "%INSTANCEDIR%\packages\WmTN\code\jars\static"           
)
rem ================================================================
rem Update CLASSPATH to include ffcore.jar, editn.jar and ediintdoc.jar for EDI documenttypes
rem ================================================================
if exist "%INSTANCEDIR%\packages\WmFlatFile\code\jars\static\ffcore.jar" (    
    set CLASSPATH=%CLASSPATH%;"%INSTANCEDIR%\packages\WmFlatFile\code\jars\static\ffcore.jar"
)
if exist "%INSTANCEDIR%\packages\WmEDIforTN\code\jars\static\editn.jar" (    
    set CLASSPATH=%CLASSPATH%;"%INSTANCEDIR%\packages\WmEDIforTN\code\jars\static\editn.jar"
)
if exist "%INSTANCEDIR%\packages\WmEDIINT\code\jars\static\ediintdoc.jar" (    
    set CLASSPATH=%CLASSPATH%;"%INSTANCEDIR%\packages\WmEDIINT\code\jars\static\ediintdoc.jar"
)
goto done

:appendToCP
set CLASSPATH=%CLASSPATH%;%1
goto :EOF

:appendJar
call :appendToCP %1
goto :EOF

:appendJarsAndZips
for %%D in (%1\*.jar,%1\*.zip) do call :appendToCP "%%D"

:appendDataDirectJar
for %%D in (%1) do call :appendToCP "%%D"

goto :EOF

:done