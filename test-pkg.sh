#!/bin/bash

MODE=""
CONFIG_NAME=nnn
CONFIG_FILE=${CONFIG_NAME}.config
CMD="./utils/test-pkg -p $CONFIG_NAME  -c $CONFIG_FILE"

if [ "$#" -ge 1 ]; then
   MODE=$1
fi


set -e
. "$HOME/.cargo/env"


cp -f configs/$CONFIG_FILE buildroot/
cd buildroot

if [ "$MODE" = "all" ]; then
  CMD+=" --all"
fi

export FORCE_UNSAFE_CONFIGURE=1
eval "$CMD"
