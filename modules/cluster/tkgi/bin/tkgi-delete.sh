#!/bin/bash
set -e
#run the login
source ./tkgi-login.sh




tkgi delete-cluster ${TKGI_CLUSTER_NAME} --wait






