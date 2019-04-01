#!/bin/sh

# Unless explicitly stated otherwise all files in this repository are licensed
# under the Apache License Version 2.0.
# This product includes software developed at Datadog (https://www.datadoghq.com/).
# Copyright 2016-2019 Datadog, Inc.

##### Core config #####

if [ -z $DD_API_KEY ]; then
	echo "You must set DD_API_KEY environment variable to run the Datadog Agent container"
	exit 1
fi

if [ -z $DD_DOGSTATSD_SOCKET ]; then
    export DD_DOGSTATSD_NON_LOCAL_TRAFFIC=1
fi

##### Starting up dogstatsd #####
if [ -z "${SPACEPODS_ENV}" ]; then
	export SPACEPODS_ENV="pod"
fi

# Remove broken default checks in docker
rm -f /etc/datadog-agent/conf.d/network.d/conf.yaml.default /etc/datadog-agent/conf.d/disk.d/conf.yaml.default

echo Copying configuration files
(cd /myconfig && find conf.d -name \*-${SPACEPODS_ENV}.yaml -ls -exec cp --parents {} /etc/datadog-agent/ \;)

# Healthcheck
(cd /httpd && busybox httpd -p 8080)

sync	# Fix for 'Text file busy' error
sleep $(((RANDOM % 60) + 10))
exec agent run
