#!/bin/bash

#Set debugger
set -x

InternetUtilInstalled() {
    if hash curl 2>/dev/null; then
	echo "curl is installed"
    elif hash wget 2>/dev/null; then
	echo "wget is installed"
    else 
	echo "Please install curl or wget"
    fi
}

InstallPrograms() {
    for i in "$@"
    do
	echo "$i"
    done
}

InternetUtilInstalled

