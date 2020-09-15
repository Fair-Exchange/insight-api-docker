apt-get install docker.io
build: 
  docker build -t safecoin-api-v4 . 
  docker volume create explorerSafecoinOrg

start: docker docker run --mount source=explorerSafecoinOrg,target=/usr/src/app/.safecoin -p 13000:3000 -it safecoin-api-v4

