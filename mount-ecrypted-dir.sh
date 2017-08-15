#!/bin/bash
if [ ! -d $1 ]; then
	echo "Missing $1"
	exit 1
fi
sudo mount -t ecryptfs $1 $1 -o key=passphrase,ecryptfs_cipher=aes,ecryptfs_key_bytes=32,ecryptfs_passthrough=n,ecryptfs_enable_filename_crypto=y
