#!/bin/bash
# set -x
run() {
    IMAGE="soda480/wait-for-message:latest"

    echo "pulling Docker image: $IMAGE"
    docker image pull $IMAGE

    echo "running Docker container: $IMAGE"
    if [ "$W4M_COMMAND" = "wait" ]; then
        echo "publish ports: $W4M_PORT"
        value=$( docker container run \
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
            "$IMAGE")
        echo "response=$value" >> $GITHUB_OUTPUT   
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