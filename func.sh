#!/bin/bash

###----------------------------- input -----------------------------###
path=$1

###----------------------------- Functions -----------------------------###

check_directory_exists() {
    if [ ! -d "$path" ]; then
        echo "Directory not found"
        exit 1
    fi
}

create_directory() {
    local dir=$1
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
    fi
}

get_file_extension() {
    local file=$1
    extension="${file##*.}"
    
    if [[ "$extension" == "$file" ]]; then
        extension="misc"
    fi
}

subdir_path() {
    local file=$1
    get_file_extension "$file"
    subdir="$path/$extension"
}

move_file() {
    local file=$1
    subdir_path "$file"
    create_directory "$subdir"
    mv "$file" "$subdir/"
}


organize_files() {
    for file in "$path"/*; do
        if [ -f "$file" ] ; then
            move_file "$file"
        fi
    done
}
