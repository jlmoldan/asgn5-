#!/bin/bash
# 2/27/17 JLM
# ./metadata.sh --> prints metadata to files.
# available options -v|-h|-c|NO OPTION SELECTED - Defaults basic usage info.

# assign variables
ACTION=${1}
VERSION="0.5.0"


#echo $ACTION

function create_files() {
     curl http://169.254.169.254/latest/dynamic/instance-identity/document/ > backend1-identity.json
     curl -vs https://s3.amazonaws.com/seis665/message.json 2>&1 | tee backend1-message.txt
     cp /var/log/nginx/access.log . 
}

function show_version() {
echo  " version: $VERSION"
}

function display_help() {

cat << EOF

Usage: ${0} {  |-c|--create|-h|--help|-v|--version} <filename>

OPTIONS:
        -c | --create   Creates files
        -h | --help     Display the command help
        -v | --version  Displays version

Examples:
        Create Metadata files
                $ ${0} -c

        Display help:
                $ ${0} -h

        Display Version
                $ ${0} -v
EOF
}

case "$ACTION" in
        -h|--help)
                display_help
                ;;
        -c|--create)
                create_files
                ;;
        -v|--version)
                show_version
                ;;

        *)
        echo "Usage ${0} {-c|-h|-v}"
        exit 1
esac
