#!/bin/bash
set -x
env | grep INPUT
env | grep W4M
if [[ "$W4M_COMMAND" = "wait" ]]
then
    w4m wait --port-number=$W4M_PORT --message="$W4M_MESSAGE" --timeout=$W4M_TIMEOUT
else
    w4m send --ip-address=$W4M_IP --port-number=$W4M_PORT --message="$W4M_MESSAGE" --delay=$W4M_DELAY --attempts=$W4M_ATTEMPTS
fi