FROM ubuntu:latest
VOLUME ["/data"]
WORKDIR /tmp
RUN apt-get update && \
    apt-get install ansible wget unzip -y && \
    wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip && \
    unzip terraform_0.12.26_linux_amd64.zip -d /usr/bin