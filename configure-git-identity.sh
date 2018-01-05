#!/bin/bash

if [ "$1" == "" ]; then
	echo "Please specify a tag for this key, e.g. \"work\" or \"personal\""
	exit 1
fi
if [ "$2" == "" ]; then
	echo "Please specify an email address for this key"
	exit 1
fi

KEY=~/.ssh/id_rsa_$1
PUBLIC_KEY=$KEY.pub
GITHUB_DOMAIN=$1.github.com
BITBUCKET_DOMAIN=$1.bitbucket.org

if [ ! -f $KEY ]; then
	ssh-keygen -t rsa -C $2 -f $KEY
    ssh-add $KEY
fi

touch ~/.ssh/config

if ! grep -Eq "$GITHUB_DOMAIN" ~/.ssh/config; then
    echo "Host $GITHUB_DOMAIN
    HostName github.com
    User git
    IdentityFile $KEY
" >> ~/.ssh/config
fi

if ! grep -Eq "$BITBUCKET_DOMAIN" ~/.ssh/config; then
    echo "Host $BITBUCKET_DOMAIN
    HostName bitbucket.org
    User git
    IdentityFile $KEY
" >> ~/.ssh/config
fi

echo "Successfully configured identities for $GITHUB_DOMAIN and $BITBUCKET_DOMAIN
Here's your public key:
------------------------------------------------"
cat $KEY.pub
echo "------------------------------------------------
You can add these keys here:
* GitHub: https://github.com/settings/keys
* BitBucket: https://bitbucket.org/account/user/USERNAME/ssh-keys/"

