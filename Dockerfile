FROM golang:1.8.1-alpine

LABEL creator="Coreos" \

      maintainer="vincent nadal <vincent.nadal@orange.com>" \

      home="https://www.forge.orange-labs.fr/plugins/git/newsec/Clair.git" \

      origin="https://github.com/coreos/clair"


VOLUME /config

EXPOSE 6060 6061

RUN apk update  && \

    apk upgrade --available

RUN apk add --no-cache git bzr rpm xz && \

    go get github.com/coreos/clair && \

    go install -v github.com/coreos/clair/cmd/clair && \

    rm -fr /var/cache


WORKDIR /

RUN mv -f /go/bin/clair /clair && \

    rm -rf /go  && \

    rm -rf /usr/local/go

ENTRYPOINT ["/clair"] 
