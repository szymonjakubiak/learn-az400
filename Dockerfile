FROM ubuntu:22.04

RUN apt-get update
RUN apt-get -y upgrade 
RUN apt-get -y install curl git jq libicu70 libpython3.10-dev

# install java
RUN apt-get -y install wget apt-transport-https gpg 
RUN wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
RUN echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list
RUN apt-get update
RUN apt-get -y install temurin-17-jdk

ENV TARGETARCH="linux-x64"

ARG DOCKER_USER_NAME=agent-will
RUN useradd $DOCKER_USER_NAME
WORKDIR /home/$DOCKER_USER_NAME

RUN curl -O https://vstsagentpackage.azureedge.net/agent/3.232.3/vsts-agent-linux-x64-3.232.3.tar.gz
RUN tar zxvf vsts-agent-linux-x64-3.232.3.tar.gz

RUN ./bin/installdependencies.sh

RUN chown $DOCKER_USER_NAME ./
USER $DOCKER_USER_NAME
