#------------------------------------------------------------
# Fano Web Framework Skeleton Application (https://fanoframework.github.io)
#
# @link      https://github.com/fanoframework/fano-app-img
# @copyright Copyright (c) 2018 Zamrony P. Juhara
# @license   https://github.com/fanoframework/fano-app-img/blob/master/LICENSE (GPL 3.0)
#--------------------------------------------------------------
#!/bin/bash

#------------------------------------------------------
# Scripts to simulate run CGI app in shell for Linux
#------------------------------------------------------

CURRDIR=$PWD

# change current working dir, to simulate how cgi
# app executed by web server
cd app/public

if [ -z "$REQUEST_METHOD" ]; then
    export REQUEST_METHOD="GET"
fi

if [ -z "$REQUEST_URI" ]; then
    export REQUEST_URI="/"
fi

./app.cgi

cd $CURRDIR