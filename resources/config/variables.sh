#!/usr/bin/env bash

# Variables must end with _CONF so their values can be placed inside the deployment file
current_path=$(pwd)

cd ../..

export NGINX_CONF_PATH_CONF=$(pwd)"/src/nginx"
export PHP_SRC_PATH_CONF=$(pwd)"/src/php"

cd $current_path
