#!/bin/sh
export APP_HOME="$(cd "`dirname "$0"`"/..; pwd)"
export DIST_PATH=${APP_HOME}/dist
export CONTENT_PATH=${APP_HOME}/content
cd ${APP_HOME}
mkdir -p ${DIST_PATH}

# set Version
VERSION=0.1
if [ -z ${1+x} ]; then
	echo "VERSION is set to 0.1";
else
	VERSION=$1
	echo "VERSION is set to '$1'";
fi

# sbt package
sbt universal:packageBin

# clear the old files in dist
if [[ -f ${DIST_PATH}/hippomanager-${VERSION}.zip ]]; then
    rm ${DIST_PATH}/hippomanager-${VERSION}.zip
fi

if [[ -d ${DIST_PATH}/hippomanager-${VERSION} ]]; then
    rm -r ${DIST_PATH}/hippomanager-${VERSION}
fi

# copy manager zip to dist
cp ${APP_HOME}/target/universal/hippomanager-${VERSION}.zip ${DIST_PATH}

# Go to dist directory
cd ${DIST_PATH}

# upzip manager zip and remove
unzip hippomanager-${VERSION}.zip
rm hippomanager-${VERSION}.zip

# copy config, readme.md to manager
cp ${CONTENT_PATH}/* hippomanager-${VERSION}/
cp -r ${CONTENT_PATH}/* hippomanager-${VERSION}/
chmod +x hippomanager-${VERSION}/scripts/*
mkdir -p hippomanager-${VERSION}/log

# package manager to zip file
zip -r hippomanager-${VERSION}.zip hippomanager-${VERSION}/


