##
## bullet's SIT LINUX Container
##

FROM ubuntu:latest AS builder
ARG SPT=-
ARG SPT_BRANCH=3.8.3
ARG NODE=20.11.1

WORKDIR /opt

# Install git git-lfs curl
RUN apt update && apt install -yq git git-lfs curl
# Install Node Version Manager and NodeJS
RUN git clone https://github.com/nvm-sh/nvm.git $HOME/.nvm || true
RUN \. $HOME/.nvm/nvm.sh && nvm install $NODE
## Clone the SPT AKI repo or continue if it exist
RUN git clone --branch $SPT_BRANCH https://dev.sp-tarkov.com/SPT-AKI/Server.git srv || true

## Check out and git-lfs (specific commit --build-arg SPT=xxxx)
WORKDIR /opt/srv/project 
RUN git checkout $SPT || true
RUN git-lfs fetch --all && git-lfs pull

## Install npm dependencies and run build
RUN \. $HOME/.nvm/nvm.sh && npm install && npm run build:release -- --arch=$([ "$(uname -m)" = "aarch64" ] && echo arm64 || echo x64) --platform=linux

## Move the built server and clean up the source
RUN mv build/ /opt/server/
WORKDIR /opt
RUN rm -rf srv/

FROM ubuntu:latest
WORKDIR /opt/
RUN apt update && apt upgrade -yq && apt install -yq dos2unix
COPY --from=builder /opt/server /opt/srv
COPY bullet.sh /opt/bullet.sh
# Fix for Windows
RUN dos2unix /opt/bullet.sh

# Set permissions
RUN chmod o+rwx /opt /opt/srv /opt/srv/* -R

# Exposing ports
EXPOSE 6969

# Specify the default command to run when the container starts
CMD bash ./bullet.sh
