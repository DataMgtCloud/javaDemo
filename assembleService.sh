#!/bin/sh

gradle build
SVC_NAME=$(grep "name=" service.properties | awk '{print substr($1, 6)}')
ARCHIVE_NAME=$(ls build/libs/*.jar | awk '{print substr($1, 12)}')

cp build/libs/$ARCHIVE_NAME /opt/jars/.
cp template/consul.json /etc/consul.d/.
cp template/startService.sh /etc/consul.d/.


sed -i 's,'"<serviceName>"','"$SVC_NAME"',g' /etc/consul.d/consul.json
sed -i 's,'"<archiveName>"','"$ARCHIVE_NAME"',g' /etc/consul.d/startService.sh
