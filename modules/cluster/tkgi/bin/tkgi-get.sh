#!/bin/bash
set -e
#run the login
source ./bin/environment.sh

tkgi cluster ${TKGI_CLUSTER_NAME} --json > bin/cluster.json








