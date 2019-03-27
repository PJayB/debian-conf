#!/bin/bash
if [ "$1" == "" ] || [ "$2" == "" ]; then
    echo "Usage: $0 <script path> <profile>"
    exit 1
fi
if [ -e "$1" ]; then
    echo "$1 already exists."
    exit 1
fi

cat > $1 << EOF
#!/bin/bash
google-chrome "--profile-directory=$2" &
EOF

chmod +x $1


