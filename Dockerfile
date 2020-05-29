FROM ubuntu:18.04

ENV HOME /usr/src/app
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y build-essential libgomp1 pkg-config m4 autoconf \
      libtool automake curl ca-certificates g++ gcc make apt-transport-https uuid-dev \
      build-essential libc6-dev m4 g++-multilib autoconf libtool ncurses-dev libsodium-dev && \
      curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get install -y nodejs

RUN curl -L https://github.com/Fair-Exchange/safecoin/releases/download/v0.36/SafecoinUbuntu-v0.36.tar.gz | tar xz && \
     /usr/src/app/safecoin/zcutil/fetch-params.sh && mkdir .safecoin

COPY package*.json ./
RUN npm install

COPY lerna.json ./
COPY safecoin.conf ./.safecoin
COPY ./packages/blake2b  ./packages/blake2b
COPY ./packages/blake2b-wasm ./packages/blake2b-wasm
COPY ./packages/bitcore-node-safecoin ./packages/bitcore-node-safecoin
COPY ./packages/bitcore-lib-safecoin ./packages/bitcore-lib-safecoin
COPY ./packages/bitcore-message-safecoin ./packages/bitcore-message-safecoin
COPY ./packages/insight-api-safecoin ./packages/insight-api-safecoin
COPY ./packages/insight-ui-safecoin ./packages/insight-ui-safecoin
COPY ./packages/safecoin-api ./packages/safecoin-api

RUN ./node_modules/.bin/lerna bootstrap

EXPOSE 3000

CMD cd /usr/src/app/packages/safecoin-api && node ../bitcore-node-safecoin/bin/bitcore-node start
