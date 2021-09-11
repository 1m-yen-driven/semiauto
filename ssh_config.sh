#!/bin/bash

set -eu

. ./env.sh

cp $HOME/.ssh/config $HOME/.ssh/config.${ISUCON}.backup
cat <<EOS >> ${HOME}/.ssh/config

Host app1
  User ${ISUCON_USER}
  HostName ${APP1}
  LocalForward localhost:10443 localhost:443
  LocalForward localhost:18080 localhost:80
  LocalForward localhost:16789 localhost:6789
  LocalForward localhost:19876 localhost:9876
  LocalForward localhost:19999 localhost:19999

Host app2
  User ${ISUCON_USER}
  HostName ${APP2}
  LocalForward localhost:20443 localhost:443
  LocalForward localhost:28080 localhost:80
  LocalForward localhost:26789 localhost:6789
  LocalForward localhost:29876 localhost:9876
  LocalForward localhost:29999 localhost:19999

Host app3
  User ${ISUCON_USER}
  HostName ${APP3}
  LocalForward localhost:30443 localhost:443
  LocalForward localhost:38080 localhost:80
  LocalForward localhost:36789 localhost:6789
  LocalForward localhost:39876 localhost:9876
  LocalForward localhost:39999 localhost:19999

Host bench
  User ${ISUCON_USER}
  HostName ${BENCH}
  LocalForward localhost:40443 localhost:443
  LocalForward localhost:40080 localhost:80
  LocalForward localhost:46789 localhost:6789
  LocalForward localhost:49876 localhost:9876
  LocalForward localhost:49999 localhost:19999
EOS
