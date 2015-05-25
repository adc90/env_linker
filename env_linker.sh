#!/bin/bash

#====================================================================
# Author: adc90
# Description: Installs all the programs listed in program_list.json
# and links all your dot files stored in '.dotfiles'
#====================================================================

#Set debugger
#set -x


#==========================================
# Confinguration variables
#==========================================
PACKAGE_MANAGER="apt-get install"
DOT_FILES=".dotfiles"

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
    for x in $@; do
        $PACKAGE_MANAGER $x
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
    if [ ! -d $DOT_FILES ]; then
        echo "Please create a dotfiles directory for env_linker to mangage."
    else
        for x in $(ls -d ${DOT_FILES}/.* | grep "^\.."); do
            #Test if the symbolic link has already been created
            if ln -s $x $HOME; then
                echo "Creating a symlink for: "$x
            else
                if [ ! -d "$HOME/.backup" ]; then
                    mkdir "$HOME/.backup"
                fi
                echo "Moving old dotfile to .backup: "$x
                mv "$HOME/"$x "$HOME/.backup/"
                echo "Creating a symlink for: "$x
                ln -s $x $HOME
            fi
        done
    fi

}

function env_linker {
    CheckRoot
    LinkDotFiles
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

function LinkTest {
    for x in $(ls -d .dotfiles/.* | grep "^\.."); do
        echo $x
    done
}

#Run the main function
env_linker

