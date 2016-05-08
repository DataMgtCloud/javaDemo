#!/bin/sh

gradle build
SVC_NAME=$(grep "name=" service.properties | awk '{print substr($1, 6)}')
ARCHIVE_NAME=$(ls build/libs/*.jar | awk '{print substr($1, 12)}')

cp build/libs/$ARCHIVE_NAME /opt/jars/.
cp template/consul.json /etc/consul.d/${SVC_NAME}.json
mkdir -p /etc/service/${SVC_NAME}
cp template/startService.sh /etc/service/${SVC_NAME}/run

sed -i 's,'"<serviceName>"','"$SVC_NAME"',g' /etc/consul.d/${SVC_NAME}.json
sed -i 's,'"<archiveName>"','"$ARCHIVE_NAME"',g' /etc/service/${SVC_NAME}/run
