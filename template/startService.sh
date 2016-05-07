#!/bin/sh

exec chpst -u svc:svc java -jar -Dserver.port=8080 /opt/jars/<archiveName>
