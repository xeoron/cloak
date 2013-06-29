#!/bin/bash
# File: cloak.sh
# Purpose: to make files and folders hidden or shown in OS X's Desktop, Finder, and Spotlight
# Author: Jason Campisi
# Date: 6/23/2013
# License: GPL 2 or higher

declare -r NAME="Cloak"
declare -r VERSION="0.2.5"

option=$1
FILE=$2

 if [ -z "$1" ]; then #if option is not set
    option="-h"
 elif [ ! -n "$FILE" ]; then
    echo " $NAME Error - File or folder name is not set!"
    exit 1;
 elif [ ! -e $FILE ]; then
    echo " $NAME Error - The location of '$FILE' does not exist!"
    exit 1;
 fi

 case $option in
    -h|--help)
        echo "Usage: $NAME <option> /location/to/folder"
        echo " "
        echo "$NAME any file/folder from Finder and Spotlight on your Mac"
        echo "-c --cloak location from Finder and Spotlight"
        echo "-u --uncloak location from Finder and Spotlight"
        echo "-v --version"
        echo "-h --help"
        echo " "
        ;;
    -u|--uncloak)
        echo " Uncloaking $FILE ..."
        chflags -H -R nohidden "$FILE"
        echo " Adding $FILE location to Spotlight's index..."
        mdimport $FILE
        ;; 
    -c|--cloak)
        echo " Cloaking $FILE ..."
    	chflags -H -R hidden "$FILE"
    	echo " Removing $FILE location from Spotlight's index..."
    	mdutil $FILE >/dev/null
        ;;
    -v|--version)
        echo " $NAME version: $VERSION"
        echo " System requirements: Mac OSX.5 Leopard or higher"
    	;;
 esac

exit 0
