REM------------------------------------------------------------
REM Fano Web Framework Skeleton Application (https://fanoframework.github.io)
REM
REM @link      https://github.com/fanoframework/fano-app-img
REM @copyright Copyright (c) 2018 Zamrony P. Juhara
REM @license   https://github.com/fanoframework/fano-app-img/blob/master/LICENSE (GPL 3.0)
REM-------------------------------------------------------------

REM------------------------------------------------------
REM Scripts to setup configuration files
REM------------------------------------------------------

copy app\config\config.json.sample app\config\config.json
copy build.prod.cfg.sample build.prod.cfg
copy build.dev.cfg.sample build.dev.cfg
copy build.cfg.sample build.cfg