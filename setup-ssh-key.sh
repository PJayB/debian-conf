#!/bin/bash

if [ "$1" == "" ]; then
	echo "Please specify a remote target (e.g. user@domain.com)"
	exit 1
fi

if [ ! -f ~/.ssh/id_rsa.pub ]; then
	ssh-keygen -t rsa
fi
cat ~/.ssh/id_rsa.pub | ssh $1 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"


