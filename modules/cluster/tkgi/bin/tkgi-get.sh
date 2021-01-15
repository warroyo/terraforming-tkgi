#!/bin/bash
set -e
#run the login
source ./tkgi-login.sh




tkgi cluster ${TKGI_CLUSTER_NAME} --json






