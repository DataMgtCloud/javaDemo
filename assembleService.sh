#!/bin/sh

gradle build
SVC_NAME="mock"
ARCHIVE_NAME="mock.jar"

cp template/consul.json /etc/consul.d/.
cp template/startService.sh /etc/consul.d/.

sed -i 's,'"<serviceName>"','"$SVC_NAME"',g' /etc/consul.d/consul.json
sed -i 's,'"<archiveName>"','"$ARCHIVE_NAME"',g' /etc/consul.d/startService.sh
