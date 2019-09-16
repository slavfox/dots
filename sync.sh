#!/usr/bin/env sh
ANSIBLE_LIBRARY="./library:$ANSIBLE_LIBRARY" ansible-playbook -Kvi hosts local_env.yml $*
