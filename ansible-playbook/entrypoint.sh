#!/bin/bash

ANSIBLE_REMOTE_USER=root
ANSIBLE_PRIVATE_KEY_FILE=id_rsa

case $1 in
    cluster|upgrade-cluster|scale|remove-node|reset )
        ansible_playbook kube-$1.yml $CLI_ARGS
        ;;
        
    kubebot-*.yml )
        ansible-playbook $1 ${@:2}
        ;;

    ansible )
        ansible "${@:2}" $CLI_ARGS
        ;;
    * )
        echo "COMMAND:"
        echo "cluster"

function ansible_playbook() {
    PLAYBOOK=$1
    if [ ! -f "${PLAYBOOK}" ]; then
        echo "playbook: [$PLAYBOOK] don't exists."
        exit 1;
    fi
    ansible-playbook ${PLAYBOOK} -e @kubebot_extra_vars.yml ${@:2}
}