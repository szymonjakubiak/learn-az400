FROM ubuntu:22.04

RUN apt update
RUN apt upgrade -y
RUN apt install -y curl git jq libicu70

ENV TARGETARCH="linux-x64"

ARG DOCKER_USER_NAME=agent-will
RUN useradd $DOCKER_USER_NAME
WORKDIR /home/$DOCKER_USER_NAME

RUN curl -O https://vstsagentpackage.azureedge.net/agent/3.232.3/vsts-agent-linux-x64-3.232.3.tar.gz
RUN tar zxvf vsts-agent-linux-x64-3.232.3.tar.gz

RUN ./bin/installdependencies.sh

RUN chown $DOCKER_USER_NAME ./
USER $DOCKER_USER_NAME
