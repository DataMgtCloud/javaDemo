#!/bin/sh

gradle build
SVC_NAME="mock"
ARCHIVE_NAME="app.jar"

cp build/libs/$ARCHIVE_NAME /opt/jars/.
cp template/consul.json /etc/consul.d/.
cp template/startService.sh /etc/consul.d/.


sed -i 's,'"<serviceName>"','"$SVC_NAME"',g' /etc/consul.d/consul.json
sed -i 's,'"<archiveName>"','"$ARCHIVE_NAME"',g' /etc/consul.d/startService.sh
