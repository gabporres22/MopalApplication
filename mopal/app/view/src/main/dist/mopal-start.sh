#!/usr/bin/env sh
set -e

./checkJavaVersion.sh 1.8

if [ $# -eq 1 ] && [ $1 = '--with-newrelic-dev' ]; then
    WORKING_DIR=`pwd`
    export JAVA_OPTIONS="$JAVA_OPTIONS -javaagent:$WORKING_DIR/newrelic/newrelic.jar -Dnewrelic.environment=development"
fi

if [ $# -eq 1 ] && [ $1 = '--with-newrelic-prod' ]; then
    WORKING_DIR=`pwd`
    export JAVA_OPTIONS="$JAVA_OPTIONS -javaagent:$WORKING_DIR/newrelic/newrelic.jar"
fi

if [ $# -eq 1 ] && [ $1 = '--with-metrics' ]; then
    WORKING_DIR=`pwd`
    export JAVA_OPTIONS="$JAVA_OPTIONS -javaagent:$WORKING_DIR/lib/aspectjweaver-1.8.1.jar -Dkamon.modules.kamon-statsd.auto-start=yes -Dkamon.modules.kamon-akka.auto-start=yes -Dkamon.statsd.hostname=10.0.1.84"
fi

export JAVA_OPTIONS="$JAVA_OPTIONS -Xmx5120M -Duser.language=es -Xloggc:/tmp/suigc.log -verbose:gc -XX:+PrintGC -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCApplicationStoppedTime -XX:+PrintGCApplicationConcurrentTime -Dcom.sun.xml.bind.v2.bytecode.ClassTailor.noOptimize=true -Djavax.xml.bind.JAXBContext=com.sun.xml.internal.bind.v2.ContextFactory -Djava.security.egd=file:///dev/./urandom -Djava.net.preferIPv4Stack=true -XX:SoftRefLRUPolicyMSPerMB=0"

cd suigeneris
cd bin

export CP=`find "../../lib" -name '*.jar' | xargs echo | tr ' ' ':'`

 ./suigeneris -m $CP -r ../../run -c ../../prod.properties start -t 2000 -p 9010
