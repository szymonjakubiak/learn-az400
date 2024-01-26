FROM alpine:latest

RUN apk update
RUN apk upgrade
RUN apk add bash curl git icu-libs jq gcompat

ENV TARGETARCH="linux-musl-x64"

ARG DOCKER_USER_NAME=agent-smith
RUN adduser -D $DOCKER_USER_NAME
WORKDIR /home/$DOCKER_USER_NAME

RUN wget https://vstsagentpackage.azureedge.net/agent/3.232.3/vsts-agent-linux-x64-3.232.3.tar.gz
RUN tar zxvf vsts-agent-linux-x64-3.232.3.tar.gz

RUN ./bin/installdependencies.sh

RUN chown $DOCKER_USER_NAME ./
USER $DOCKER_USER_NAME
