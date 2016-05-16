@echo off

set DIRNAME=%~dp0
set ROOT_DIR=%DIRNAME%\..\..\..\..\..\..

set IS_DIR=%ROOT_DIR%\IntegrationServer
set JVM_DIR=%ROOT_DIR%\jvm\jvm

IF [%1]==[] ( "%JVM_DIR%\bin\java" -classpath "%IS_DIR%\..\common\lib\wm-scg-security.jar;%IS_DIR%\..\common\lib\wm-scg-core.jar;%IS_DIR%/packages/WmDeployer/lib/CLI.jar;%IS_DIR%/packages/WmDeployer/code/classes;%IS_DIR%/../common/lib/ext/jargs.jar;%IS_DIR%\..\common\lib\wm-isclient.jar;%IS_DIR%\..\common\lib\glassfish\gf.javax.mail.jar;%IS_DIR%\..\common\lib\ext\log4j.jar;%IS_DIR%/../common/lib/ext/enttoolkit.jar;log4j.properties;%IS_DIR%\packages\WmDeployer\bin" com.wm.deployer.CLI.MainClass "--usage" ) ELSE ( "%JVM_DIR%\bin\java" -classpath "%IS_DIR%\..\common\lib\wm-scg-security.jar;%IS_DIR%\..\common\lib\wm-scg-core.jar;%IS_DIR%/packages/WmDeployer/lib/CLI.jar;%IS_DIR%/packages/WmDeployer/code/classes;%IS_DIR%/../common/lib/ext/jargs.jar;%IS_DIR%\..\common\lib\wm-isclient.jar;%IS_DIR%\..\common\lib\glassfish\gf.javax.mail.jar;%IS_DIR%\..\common\lib\ext\log4j.jar;%IS_DIR%/../common/lib/ext/enttoolkit.jar;%IS_DIR%\packages\WmDeployer\bin;%IS_DIR%\packages\WmDeployer\bin\log4j.properties" com.wm.deployer.CLI.MainClass %* )
