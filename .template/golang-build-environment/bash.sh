#!/usr/bin/env bash

# Expected to be executed from the `go/` directory, so temporarily cd:
cd ../.template/golang-build-environment
test $? -eq 0 || exit 1

REGISTRY=$(cat ../.registry)
PROGRAM=$(cat ../.program)

RUNTIME=$(../../scripts/get-container-runtime)

function tag {
    if [ "$(uname)" == "Darwin" ]; then
        md5 -q Dockerfile
    else
        md5sum Dockerfile | cut -d ' ' -f 1
    fi
}

IMAGE="${REGISTRY}${PROGRAM}-golang:$(tag)"

function check-status {
    STATUS=$1
    if [ "$STATUS" != "0" ]; then
        cat .runtime.log
        exit $STATUS
    fi
}

function image-exists-locally {
    $RUNTIME image inspect $IMAGE &> .runtime.log
}

function try-pulling-image {
    if [ "$REGISTRY" != "" ]; then
        $RUNTIME pull $IMAGE &> .runtime.log
    else
        false
    fi
}

if ! image-exists-locally; then
    if ! try-pulling-image; then
        $RUNTIME build -t $IMAGE . &> .runtime.log
        check-status $?
        if [ ! -z "$REGISTRY" ]; then
            $RUNTIME push $IMAGE &> .runtime.log
            check-status $?
        fi
    fi
fi

if [ "$RUNTIME" = "podman" ]; then
    USERNS=--userns=keep-id
elif [ "$RUNTIME" = "docker" ]; then
    USERNS=--user=$(id -u):$(id -g)
else
    echo "Unexpected runtime: $RUNTIME"
    exit 1
fi

mkdir -p .home

# cd back to the `go/` directory:
cd ../../go

exec $RUNTIME run \
    --rm \
    -it \
    $USERNS \
    -e USER=$(whoami) \
    -e USERNAME=$(whoami) \
    -v "$(pwd)/../.template/golang-build-environment/.home:/home/build-env:z" \
    -e HOME=/home/build-env \
    -v "$(pwd):/src:z" \
    --workdir=/src \
    $IMAGE \
        /bin/bash "$@"
