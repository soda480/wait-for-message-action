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
            --entrypoint= \
            -p $W4M_PORT:$W4M_PORT \
            "$IMAGE" \
            w4m wait --port-number=$W4M_PORT --message="$W4M_MESSAGE" --timeout=$W4M_TIMEOUT)
        echo "response=$value" >> $GITHUB_OUTPUT   
    else
        docker container run \
            --rm \
            --entrypoint= \
            "$IMAGE" \
            w4m send --ip-address=$W4M_IP --port-number=$W4M_PORT --message="$W4M_MESSAGE" --delay=$W4M_DELAY --attempts=$W4M_ATTEMPTS
    fi

    run_exit=$?
    return $run_exit
}

run
script_exit=$?

exit $script_exit
