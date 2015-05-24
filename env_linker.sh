#!/bin/bash

#Set debugger
#set -x

PackageManager="apt-get install"

function InternetUtilInstalled {
    if hash curl 2>/dev/null; then
        echo "curl is installed"
    elif hash wget 2>/dev/null; then
        echo "wget is installed"
    else 
        echo "Please install curl or wget"
    fi
}

function InstallPrograms {
    if [ -z "$1" ]; then
        echo "No programs listed in programList.json"
        exit 0
    fi
    for x in $@; do
        $PackageManager $x
    done
}

function CheckRoot {
    if [ "$(id -u)" != "0" ]; then
        echo "Please run env_linker as root"
        exit 0
    else
        echo "You're root"
    fi
}

function ParseList {
    programList="program_list.json"
    cat $programList | ./jq '.programs' | sed 's/[][]//g' | sed 's/"//g' | \
        sed 's/,//g' | sed ':a;N;$!ba;s/\n//g' | sed 's/^[ \t]*//g'
}

function LinkDotFiles {
    
    for x in $(ls -d .dotfiles/.* | grep "^\.."); do
        if ln -s $x $HOME; then
            echo $x
        else

        fi
    done
}

function env_linker {
    #Check if the user is root otherwise exit
    LinkDotFiles
    CheckRoot 
    InstallPrograms $(ParseList)
}

function CompareFiles {
    file1= `md5 $1`
    file2= `md5 $2`
    if [ "$file1" == "$file2" ]; then
        echo "Files have the same content"
    else
        echo "Files have NOT the same content"
    fi
}

#Main function
env_linker


