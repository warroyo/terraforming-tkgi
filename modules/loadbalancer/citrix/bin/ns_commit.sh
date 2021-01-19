#!/bin/bash
set -e
curl  -k -XPOST -H 'Content-type: application/json' -H "X-NITRO-USER:${NS_USER}" -H "X-NITRO-PASS:${NS_PASSWORD}" ${NS_URL}nitro/v1/config/nsconfig?action=save -d '{"nsconfig": {}}'