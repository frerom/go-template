FROM docker.io/golang:1.14.0-buster

RUN apt-get update && apt-get install less && \
    rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/log/dpkg.log /var/cache/* && \
    \
    mkdir /tools && \
    cd /tools && \
    go mod init example.com/tools && \
    mkdir /tools/bin && \
    \
    cd /tools && \
    curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s v1.23.7 && \
    go get github.com/dnephin/filewatcher@v0.3.2 && \
    \
    cd /tools && \
    go build -o bin/filewatcher github.com/dnephin/filewatcher && \
    \
    rm -rf /go/pkg /go/src && \
    \
    chmod -R 777 /go && chmod -R 777 /tools

ENV PATH=/tools/bin:$PATH
