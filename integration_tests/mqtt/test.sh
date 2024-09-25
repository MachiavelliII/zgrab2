#!/usr/bin/env bash

set -e
MODULE_DIR=$(dirname $0)
ZGRAB_ROOT=$(git rev-parse --show-toplevel)
ZGRAB_OUTPUT=$ZGRAB_ROOT/zgrab-output

mkdir -p $ZGRAB_OUTPUT/mqtt

CONTAINER_NAME=zgrab_mqtt

OUTPUT_FILE=$ZGRAB_OUTPUT/mqtt/mqtt.json

echo "mqtt/test: Tests runner for mqtt"
# TODO FIXME: Add any necessary flags or additional tests
CONTAINER_NAME=$CONTAINER_NAME $ZGRAB_ROOT/docker-runner/docker-run.sh mqtt > $OUTPUT_FILE
CONTAINER_NAME=$CONTAINER_NAME $ZGRAB_ROOT/docker-runner/docker-run.sh mqtt --v5 >> $OUTPUT_FILE

# Dump the docker logs
echo "mqtt/test: BEGIN docker logs from $CONTAINER_NAME [{("
docker logs --tail all $CONTAINER_NAME
echo ")}] END docker logs from $CONTAINER_NAME"

# TODO: If there are any other relevant log files, dump those to stdout here.
