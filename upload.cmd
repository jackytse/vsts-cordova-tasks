@ECHO OFF
CALL tfx --version > NUL
IF NOT ERRORLEVEL==0 GOTO TFXINSTALL

:NPMINSTALL
IF NOT EXIST node_modules (
	ECHO Installing dependencies...
	CALL npm install
	IF NOT ERRORLEVEL==0 GOTO INSTALLFAILED
)

:EXEC
CALL node bin/tfxupload.js
IF NOT ERRORLEVEL==0 GOTO INSTALLFAILED
EXIT /B 0

:TFXINSTALL
ECHO Installing tfx-cli...
CALL npm install -g tfx-cli
IF NOT ERRORLEVEL==0 GOTO INSTALLFAILED
ECHO Log in to the VSO/TFS collection you wish to deploy the tasks.
CALL tfx login
IF NOT ERRORLEVEL==0 GOTO LOGINFAILED
GOTO NPMINSTALL

:INSTALLFAILED
ECHO Failed to install npm package. Ensure Node.js is installed and in your path.
EXIT /B 1

:LOGINFAILED
ECHO Login failed.
EXIT /B 1
