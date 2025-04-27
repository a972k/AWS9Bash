#!/bin/bash

list_files() {
    echo "Listing files sorted by size ($1)"
    if [ "$1" == "asc" ]; then
        ls -lS --block-size=M | sort -k5 -n
    else
        ls -lS --block-size=M
    fi
}

count_files_by_extension() {
    echo "Counting files by extension:"
    for ext in $(find . -type f | sed -n 's/..*\.//p' | sort | uniq); do
        count=$(find . -type f -name "*.$ext" | wc -l)
        size=$(find . -type f -name "*.$ext" -exec du -ch {} + | grep total$ | awk '{print $1}')
        echo "$ext: $count files, $size"
    done
}

show_folder_size() {
    total_size=$(du -sh . | awk '{print $1}')
    echo "Total folder size: $total_size"
    
    threshold="100M"
    if [[ "$total_size" > "$threshold" ]]; then
        echo "Folder size exceeds $threshold!"
        echo "Consider compressing or deleting files."
    fi
}

utility_menu() {
    echo "Utility Options:"
    echo "1. List files ascending by size"
    echo "2. List files descending by size"
    echo "3. Count files by extension"
    echo "4. Show folder total size"
    read -p "Choose an option: " option

    case $option in
        1) list_files "asc" ;;
        2) list_files "desc" ;;
        3) count_files_by_extension ;;
        4) show_folder_size ;;
        *) echo "Invalid option" ;;
    esac
}

utility_menu