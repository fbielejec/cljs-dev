FROM adoptopenjdk/openjdk8:x86_64-ubuntu-jdk8u202-b08
MAINTAINER "Filip Bielejec" <nodrama.io>

# ENV variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 11.0.0

# install system-wide deps
RUN apt-get update -y \
    && apt-get install --no-install-recommends -y \
    -q curl git ssh tar gzip ca-certificates build-essential

# install nvm
# https://github.com/creationix/nvm#install-script
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash

# install node and npm
RUN . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to PATH
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# install yarn
RUN npm install -g yarn

# seems to fix the checksum problem
# see https://stackoverflow.com/questions/47545940/npm-err-code-eintegrity-npm-5-3-0
RUN npm config set package-lock false

# run some checks
RUN java -version
RUN node --version
RUN npm --version
RUN yarn --version
