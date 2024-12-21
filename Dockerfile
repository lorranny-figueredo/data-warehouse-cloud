FROM ubuntu:latest

LABEL maintainer="Lorranny"

RUN apt-get update && \
    apt-get install -y wget unzip curl git openssh-client iputils-ping postgresql postgresql-contrib

ENV TERRAFORM_VERSION=1.9.5

RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_arm64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_arm64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_${TERRAFORM_VERSION}_linux_arm64.zip

RUN mkdir /iac
VOLUME /iac

RUN mkdir Downloads && \
    cd Downloads && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

CMD ["/bin/bash"]

