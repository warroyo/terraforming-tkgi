# syntax=docker/dockerfile:1.2
FROM ubuntu:bionic

RUN --mount=type=secret,id=pivnet_token \
     apt-get update && apt-get install -y curl jq gnupg2 lsb-release software-properties-common && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt-get install -y terraform && \
    ACCESS=$(curl -X POST https://network.pivotal.io/api/v2/authentication/access_tokens -d '{"refresh_token":"'$(cat /run/secrets/pivnet_token)'"}' | jq -r .access_token) && \
    curl -v -L -o /usr/local/bin/tkgi -X GET https://network.pivotal.io/api/v2/products/pivotal-container-service/releases/802556/product_files/855359/download -H "Authorization: Bearer $ACCESS"  && \
    chmod +x /usr/local/bin/tkgi