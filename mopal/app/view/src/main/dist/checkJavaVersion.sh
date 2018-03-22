#!/bin/bash

if [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    _java="$JAVA_HOME/bin/java"
elif type -p java; then
    _java=java
else
    echo "no java found"
    exit 1
fi

if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
#    echo version "$version"
    if [[ "$version" == *$1* ]]; then
#        echo version is 1.6
        exit 0
    else
        echo incompatible java version: $version
        exit 1
    fi
fi
