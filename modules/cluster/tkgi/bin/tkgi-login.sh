#!/bin/bash

set -e

#check if ssl skip is needed
SKIP_SSL=""
if [ "${TKGI_SKIP_SSL_VALIDATION}" = "true" ]
then
SKIP_SSL="-k"
fi

#login to tkgi
tkgi login -a ${TKGI_API_URL} -u ${TKGI_USER} -p ${TKGI_PASSWORD} ${SKIP_SSL}