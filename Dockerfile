# syntax=docker/dockerfile:1.2
FROM ubuntu:bionic

RUN --mount=type=secret,id=pivnet_token \
     apt-get update && apt-get install -y curl jq gnupg2 lsb-release software-properties-common libdigest-sha-perl graphviz && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt-get install -y terraform && \
    ACCESS=$(curl -X POST https://network.pivotal.io/api/v2/authentication/access_tokens -d '{"refresh_token":"'$(cat /run/secrets/pivnet_token)'"}' | jq -r .access_token) && \
    curl -v -L -o /usr/local/bin/tkgi -X GET https://network.pivotal.io/api/v2/products/pivotal-container-service/releases/802556/product_files/855359/download -H "Authorization: Bearer $ACCESS"  && \
    chmod +x /usr/local/bin/tkgi && \
    TF_CITRIX_PLUGIN_VERSION=0.12.36 && \
    curl -LO "https://github.com/citrix/terraform-provider-citrixadc/releases/download/v${TF_CITRIX_PLUGIN_VERSION}/terraform-provider-citrixadc_${TF_CITRIX_PLUGIN_VERSION}_linux_amd64.tar.gz" && \
    mkdir -p ~/.terraform.d/plugins/registry.terraform.io/hashicorp/citrixadc/0.12.36/ && \
    tar xzvf terraform-provider-citrixadc_0.12.36_linux_amd64.tar.gz -C ~/.terraform.d/plugins/registry.terraform.io/hashicorp/citrixadc/0.12.36/ && \
    rm -Rf terraform-provider-citrixadc_0.12.36_linux_amd64.tar.gz && \
    TF_K14S_PLUGIN_VERSION=0.6.0 && \
    mkdir -p ~/.terraform.d/plugins/registry.terraform.io/hashicorp/k14s/$TF_K14S_PLUGIN_VERSION && \
    curl -LO "https://github.com/k14s/terraform-provider-k14s/releases/download/v${TF_K14S_PLUGIN_VERSION}/terraform-provider-k14s-binaries.tgz" && \
    tar xzvf terraform-provider-k14s-binaries.tgz -C ~/.terraform.d/plugins/registry.terraform.io/hashicorp/k14s/$TF_K14S_PLUGIN_VERSION && \
    rm -Rf terraform-provider-k14s-binaries.tgz && \
    curl -L https://carvel.dev/install.sh | bash