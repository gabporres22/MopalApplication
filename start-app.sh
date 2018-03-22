#!/bin/bash

uso() {
    echo "Uso:"
    echo "start-app -d [DEPLOY] -p [PROP]"
    echo "  d: Carpeta de instalacion"
    echo "  p: Nombre del properties (ejemplo: ibottero.properties)"
    echo ""
    echo "Ejemplo de uso: startApp -d /tmp/deploy -p ibottero.properties"
    exit 1
}

if [ $# -le 3 ]
then
    uso
fi

echo "`dirname $0`"

while getopts ":d:p:" opt; do
    case ${opt} in
        d)
            DEPLOY=$OPTARG
            ;;
        p)
            PROP=$OPTARG
            ;;
        \?)
            uso
            ;;
        :)
            uso
            ;;
    esac
done

GUL=${DEPLOY}/mopal

rm -fr ${DEPLOY}
mkdir ${DEPLOY}

#######################################################################################################################################################
echo -e "\x1B[32m 1) Installing Mopal on $DEPLOY \x1B[0m"
#######################################################################################################################################################
gradle build -x test installDist

mkdir ${GUL}
cp -r suigeneris ${GUL}
#rm ${GUL}/suigeneris/lib/http*.jar

# resources
mkdir ${GUL}/lib
cp ./mopal/app/view/build/install/mopal/lib/*.jar ${GUL}/lib
cp ./lib/*.jar ${GUL}/lib
cp ./mopal/app/view/src/main/dist/*.sh ${GUL}
cp ./mopal/app/model/src/main/resources/${PROP} ${GUL}
mv ${GUL}/${PROP} ${GUL}/prod.properties

mkdir ${GUL}/resources/
mkdir ${GUL}/resources/sql
mkdir ${GUL}/resources/sql/resources
cp -r ./mopal/app/model/src/main/mm ${GUL}/resources

cd ${GUL}


#######################################################################################################################################################
echo -e "\x1B[32m 2) Starting App Services (debug port 5006) \x1B[0m"
#######################################################################################################################################################
#export JAVA_OPTIONS="-Dgul.akka.profile=true -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5006 -Dgulliver.pvm.enabled=true "
export JAVA_OPTIONS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5006"
./mopal-start.sh

exit 0
