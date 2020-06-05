FROM ubuntu:latest
RUN apt-get update && \
    apt-get install ansible wget unzip python3-pip -y && \
    pip3 install boto && \
    wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip -O /tmp/terraform_0.12.26_linux_amd64.zip && \
    unzip /tmp/terraform_0.12.26_linux_amd64.zip -d /usr/bin
