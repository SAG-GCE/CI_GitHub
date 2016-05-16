@echo off
set DIRNAME=%~dp0
set ROOT_DIR=%DIRNAME%\..\..\..\..\..\..

set IS_DIR=%ROOT_DIR%\IntegrationServer
set JVM_DIR=%ROOT_DIR%\jvm\jvm

IF [%1]==[] ( echo "Please provide an input XML file. For information on how to create the XML file please refer to documentation" ) ELSE ( "%JVM_DIR%\bin\java" -Dserver.install.dir=%IS_DIR% -classpath "%IS_DIR%\lib\wm-isserver.jar;%IS_DIR%\packages\WmDeployer\lib\CLI.jar;%IS_DIR%\packages\WmDeployer\lib\projectautomator.jar;%IS_DIR%\packages\WmDeployer\code\classes;%IS_DIR%\..\common\lib\ext\jargs.jar;%IS_DIR%\..\common\lib\wm-isclient.jar;%IS_DIR%\..\common\lib\glassfish\gf.javax.mail.jar;%IS_DIR%\..\common\lib\ext\xml-apis.jar;%IS_DIR%\..\common\lib\ext\xercesImpl.jar;%IS_DIR%\..\common\lib\ext\log4j.jar;%IS_DIR%\..\common\lib\ext\enttoolkit.jar;%IS_DIR%\..\common\lib\wm-scg-security.jar;%IS_DIR%\..\common\lib\wm-scg-core.jar;%IS_DIR%\..\common\lib\wm-g11nutils.jar" com.softwareag.webm.deployer.automation.MainClass %* %IS_DIR%\packages\WmDeployer\config\ProjectAutomatorForRuntime.xsd %IS_DIR%\packages\WmDeployer\config\ProjectAutomatorForRepository.xsd %IS_DIR%\packages\WmDeployer\bin\log4j.properties 1)

set returnValue=%ERRORLEVEL%
IF %returnValue% NEQ 0 echo Error Code = %returnValue%
exit /b %returnValue%