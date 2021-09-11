#!/bin/bash

shopt -s expand_aliases

export ISUCON=isucon10f-renshuu

# mac
if [[ "$(uname)" == "Darwin" ]]; then
  alias readlink="greadlink" # `brew install coreutils`
  alias sed="gsed" # `brew install gnu-sed`
fi

# ssh config
export APP1=127.0.0.1
export APP2=127.0.0.1
export APP3=127.0.0.1
export APP_IPS=(${APP1} ${APP2} ${APP3})
export APP_NAMES=(app1 app2 app3)
export BENCH=127.0.0.1

export ISUCON_USER=isucon

# deploy config
export DEPLOY_KEY_SECRET=$(readlink -f ./id_rsa)
export DEPLOY_KEY_PUBLIC=$(readlink -f ./id_rsa.pub)

# GitHub config
export REPO="git@github.com:1m-yen-driven/${ISUCON}.git"

# common
alias ssh="ssh -o ClearAllForwardings=yes -tt"

# make config
export MAKE_ENV_LOADED=1
