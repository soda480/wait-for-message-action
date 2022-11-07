#!/bin/sh
set -x
run() {
    IMAGE="w4mgha:latest"
    echo "running Docker container: $IMAGE"
    if [ ! -z \"$W4M_PORT\" ]
    then
        docker container run \
            --rm \
            -e http_proxy \
            -e https_proxy \
            -e W4M_COMMAND \
            -e W4M_IP \
            -e W4M_PORT \
            -e W4M_MESSAGE \
            -e W4M_DELAY \
            -e W4M_ATTEMPTS \
            -e W4M_TIMEOUT \
            -p $W4M_PORT:$W4M_PORT \
            "$IMAGE"
    else
        docker container run \
            --rm \
            -e http_proxy \
            -e https_proxy \
            -e W4M_COMMAND \
            -e W4M_IP \
            -e W4M_PORT \
            -e W4M_MESSAGE \
            -e W4M_DELAY \
            -e W4M_ATTEMPTS \
            -e W4M_TIMEOUT \
            "$IMAGE"
    fi

    run_exit=$?
    return $run_exit
}

run
script_exit=$?

exit $script_exit