#!/bin/bash

#Set debugger
set -x

PackageManager="apt-get install"

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

CheckRoot(){
    if [ "$(id -u)" != "0" ]; then
	echo "Sorry, you are not root."
	exit 1
    else
	echo "You're root"
	exit 0
    fi
}

CheckFile(){
    #Check if the dots files are in the home
    #directory and if they are move them
    #gbd-doc
    #bash-completion
    #ln -sf
}

InternetUtilInstalled
CheckRoot
