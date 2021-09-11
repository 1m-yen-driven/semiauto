#!/bin/bash

set -eu

. ./env.sh

init_settings=$(mktemp)
cat <<EOF >$init_settings
sudo apt update
sudo apt install -y git curl
curl https://raw.githubusercontent.com/Muratam/dotfiles/isucon/init.sh | bash
EOF
for app in ${APP_NAMES[@]]}; do
  scp $init_settings $app:/tmp/init_settings
  ssh $app "bash /tmp/init_settings"
done
