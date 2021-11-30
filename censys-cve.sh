#!/usr/bin/env bash

CURPWD=$PWD
NVDFILES=$PWD/nvd
NVDBINS=$PWD/build/nvdtools/build/bin
HOST=$1

if ! [ -x "$(command -v git)" ]; then
    echo "git not installed. install it."
    exit 1
fi
 
if ! [ -x "$(command -v go)" ]; then
    echo "go not installed. install it."
    exit 1
fi

if ! [ -x "$(command -v censys)" ]; then
    echo "censys command-line tool not installed. install it."
    exit 1
fi

if [ ! -d "$NVDBINS" ]
then
    mkdir ./build/ && git clone https://github.com/facebookincubator/nvdtools.git build/nvdtools
    cd build/nvdtools 
    go mod init github.com/facebookincubator/nvdtools
    go get github.com/BurntSushi/toml \
        github.com/facebookincubator/flog \
        github.com/pkg/errors \
        golang.org/x/sync/errgroup \
        golang.org/x/oauth2 \
        golang.org/x/oauth2/clientcredentials \
        github.com/spf13/cobra \
        github.com/dgrijalva/jwt-go \
        github.com/go-sql-driver/mysql \
        github.com/spf13/pflag
    make
    cd $CURPWD
fi

if [ ! -d "$NVDFILES" ]
then
    mkdir $NVDFILES
    $NVDBINS/nvdsync -v=1 -cve_feed=cve-1.1.json.gz $NVDFILES
fi

censys view $HOST |\
    jq -r '.services[]|select(.software!=null)|.software[]|select(.uniform_resource_identifier!=null)|.uniform_resource_identifier'|\
    sort -s      | \
    uniq         | \
    tr '\n' ','  | \
    sed 's/.$//' | \
    $NVDBINS/cpe2cve -d2 ',' \
     -cpe 1 \
     -cvss3 2 \
     -cvss2 3 \
     -matches 4 \
     -cve 1 \
     -e 1\
     -require_version $NVDFILES/nvdcve-1.1-*.json.gz
