#!/bin/bash

indent=0

function print_indent() {
    for ((i=0; i<$indent; i++))
    do
        echo -n "  "
    done
}

function read_dir() {
    include=$2
    for file in `ls $1 | sort -d`
    do
        if [ -d $1"/"$file ]
        then
            print_indent
            echo "- $file"
            indent=$((indent+1))
            read_dir $1"/"$file $include
            indent=$((indent-1))
        else
            if [[ $file =~ $include ]]
            then
                print_indent
                echo "- [$file]($(echo "$1/$file" | sed 's/ /%20/g'))"
            fi
        fi
    done
}

IFS=$'\n'
read_dir $1 $2
unset IFS