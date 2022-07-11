#!/bin/bash -i

set -eu

. ./env.sh

GIT_ROOT=$(\
  ssh ${APP_NAMES[0]} \
    'find $(readlink -f .) \
      -maxdepth 4 \
      -type d \
      -printf "%d\t%p\n" \
    ' \
  | sort -n | cut -f 2 | peco --prompt "GIT_ROOT:" | cat -)

read -p "Show files in \$GIT_ROOT? [Y/n]:" yn
case "$yn" in [nN]*) ;; *) ssh ${APP_NAMES[0]} "ls $GIT_ROOT" ;; esac

read -p "Save GIT_ROOT=${GIT_ROOT}; ok? [y/N]:" yn
case "$yn" in [yY]*) ;; *) echo "abort." ; exit 1;; esac
perl -i -pe "s:export GIT_ROOT=.*:export GIT_ROOT=${GIT_ROOT}:g" ./env.sh

git_init=$(mktemp)
cat <<EOF >$git_init
  cd "${GIT_ROOT}"
  git init
  git config --global user.name "${APP_NAMES[0]}"
  git config --global user.email "${APP_NAMES[0]@example.com}"
  git remote add origin "${REPO}"
EOF
scp $git_init "${APP_NAMES[0]}":/tmp/git_init
ssh "${APP_NAMES[0]}" "bash /tmp/git_init"
echo "Add files and push them to origin"
ssh "${APP_NAMES[0]}"

read -p "Sync remaining server's \$GIT_ROOT, ok? [y/N]:" yn
case "$yn" in [yY]*) ;; *) echo "abort." ; exit 1;; esac

for ((i = 1; i < ${#APP_NAMES[@]}; i++)) {
  git_sync=$(mktemp)
  cat <<EOF >$git_sync
    mv "${GIT_ROOT}" "${GIT_ROOT}.backup"
    git config --global user.name "${APP_NAMES[$i]}"
    git config --global user.email "${APP_NAMES[$i]}@example.com"
    git -c core.sshCommand="ssh -o 'StrictHostKeyChecking=no' -F /dev/null" clone "$REPO" "$GIT_ROOT"
    rsync -a "${GIT_ROOT}.backup/" "${GIT_ROOT}/"
EOF
  scp $git_sync "${APP_NAMES[$i]}":/tmp/git_sync
  ssh "${APP_NAMES[$i]}" "bash /tmp/git_sync"
}
