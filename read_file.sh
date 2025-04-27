#!/bin/bash

read_file() {
    read -p "Enter filename to read: " filename
    if [ ! -f "$filename" ]; then
        echo "File not found!"
        exit 1
    fi

    line_number=0
    while IFS= read -r line
    do
        ((line_number++))
        echo "Line $line_number: $line"
    done < "$filename"

    word_count=$(wc -w < "$filename")
    line_count=$(wc -l < "$filename")
    size=$(du -h "$filename" | awk '{print $1}')

    echo "Total words: $word_count"
    echo "Total lines: $line_count"
    echo "Total size: $size"
}

search_file() {
    read -p "Enter filename to search: " filename
    read -p "Enter search term: " term

    if grep -q "$term" "$filename"; then
        echo "Term '$term' found!"
        grep -n --color=always "$term" "$filename"
    else
        echo "Term '$term' not found."
    fi
}

read_file_menu() {
    echo "Read File Options:"
    echo "1. Read file"
    echo "2. Search in file"
    read -p "Choose an option: " option

    case $option in
        1) read_file ;;
        2) search_file ;;
        *) echo "Invalid option" ;;
    esac
}

read_file_menu
