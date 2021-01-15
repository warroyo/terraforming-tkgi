#!/bin/bash
set -e
#run the login
source ./tkgi-login.sh


#check if cluster exist

tkgi cluster ${TKGI_CLUSTER_NAME}
RESULT=$?
if [[ ${RESULT} = 0 ]]; then
    #cluster exists update it
    echo "cluster exists running update..."
    tkgi update-cluster --num-nodes ${TKGI_WORKER_COUNT} --tags ${TKGI_TAGS} --wait
else
   #cluster does not exist create it
   echo "creating cluster..."
   tkgi create-cluster  ${TKGI_CLUSTER_NAME} -e ${TKGI_EXTERNAL_HOSTNAME} -p ${TKGI_PLAN} --tags ${TKGI_TAGS} --num-nodes ${TKGI_WORKER_COUNT} --wait
fi





