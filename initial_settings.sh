#!/bin/bash

set -eu

. ./env.sh

for app in ${APP_NAMES[@]]}; do
  init_settings=$(mktemp)
  cat <<EOF >$init_settings
sudo apt update
sudo apt install -y git curl
curl https://raw.githubusercontent.com/Muratam/dotfiles/isucon/init.sh | bash
sudo hostnamectl set-hostname ${app}
EOF
  scp $init_settings $app:/tmp/init_settings
  ssh $app "bash /tmp/init_settings"
done
