REM------------------------------------------------------------
REM Fano Web Framework Skeleton Application (https://fanoframework.github.io)
REM
REM @link      https://github.com/fanoframework/fano-app-img
REM @copyright Copyright (c) 2018 Zamrony P. Juhara
REM @license   https://github.com/fanoframework/fano-app-img/blob/master/LICENSE (GPL 3.0)
REM-------------------------------------------------------------

REM ------------------------------------
REM -- build script for Windows
REM ------------------------------------


IF NOT DEFINED FANO_DIR (SET FANO_DIR="fano")
IF NOT DEFINED BUILD_TYPE (SET BUILD_TYPE="prod")
IF NOT DEFINED USER_APP_DIR (SET USER_APP_DIR="app")
IF NOT DEFINED UNIT_OUTPUT_DIR (SET UNIT_OUTPUT_DIR="bin\unit")
IF NOT DEFINED EXEC_OUTPUT_DIR (SET EXEC_OUTPUT_DIR="public")
IF NOT DEFINED EXEC_OUTPUT_NAME (SET EXEC_OUTPUT_NAME="app.cgi")
IF NOT DEFINED SOURCE_PROGRAM_NAME (SET SOURCE_PROGRAM_NAME="app.pas")
IF NOT DEFINED FPC_BIN (SET FPC_BIN="fpc")

%FPC_BIN% @fano/fano.cfg @build.cfg %USER_APP_DIR%\%SOURCE_PROGRAM_NAME%
