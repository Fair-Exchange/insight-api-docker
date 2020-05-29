apt-get install docker.io
build: docker build -t safecoin-api-v4 .
start: docker run -p 3000:3000 safecoin-api-v4
