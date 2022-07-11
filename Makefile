SHELL=/bin/bash

.PHONY: all
all: ssh_config initial_settings distribute_deploy_key git_sync
	echo hoge

.PHONY: ssh_config
ssh_config: env.sh
	./ssh_config.sh

.PHONY: initial_settings
initial_settings: env.sh
	./initial_settings.sh

.PHONY: distribute_deploy_key
distribute_deploy_key: env.sh
	./distribute_deploy_key.sh

.PHONY: git_sync
git_sync: env.sh
	./git_sync.sh

.PHONY: echo_env
echo_env: env.sh
	echo ${APP1}

.PHONY: clean
clean:
	./clean.sh
