#!/bin/bash

set -eu

. ./env.sh

DEPLOY_KEY=.ssh/deploy_key.${ISUCON}
deploy_key=$(mktemp)
cat <<EOF >$deploy_key
chmod 600 ~/${DEPLOY_KEY}
cat <<XXX >>~/.ssh/config

Host github.com
  HostName github.com
  IdentityFile ~/${DEPLOY_KEY}
  User git
XXX
chmod 600 ~/.ssh/config
EOF
for app in ${APP_NAMES[@]}; do
  scp ${DEPLOY_KEY_SECRET} $app:~/${DEPLOY_KEY}
  scp $deploy_key $app:/tmp/deploy_key
  ssh $app "bash /tmp/deploy_key"
done
