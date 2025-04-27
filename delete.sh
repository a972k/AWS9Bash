#!/bin/bash

delete_file() {
    read -p "Enter filename to delete: " filename
    if [ ! -f "$filename" ]; then
        echo "File not found!"
        exit 1
    fi

    read -p "Are you sure you want to delete $filename? (yes/no): " confirm
    if [ "$confirm" == "yes" ]; then
        rm "$filename"
        echo "File deleted."
    else
        echo "Cancelled."
    fi
}

delete_all_in_folder() {
    read -p "Enter folder path: " folder
    if [ ! -d "$folder" ]; then
        echo "Folder not found!"
        exit 1
    fi

    file_count=$(find "$folder" -type f | wc -l)
    total_size=$(du -sh "$folder" | awk '{print $1}')

    echo "Folder has $file_count files using $total_size."
    read -p "Delete ALL files? (yes/no): " confirm
    if [ "$confirm" == "yes" ]; then
        find "$folder" -type f -exec rm -v {} +
        echo "All files deleted."
    else
        echo "Cancelled."
    fi
}

delete_by_extension() {
    read -p "Enter extension to delete (e.g., txt): " ext
    files=$(find . -type f -name "*.$ext")

    if [ -z "$files" ]; then
        echo "No files found."
        exit 1
    fi

    echo "Files found:"
    echo "$files"

    read -p "Delete all .$ext files? (yes/no): " confirm
    if [ "$confirm" == "yes" ]; then
        find . -type f -name "*.$ext" -exec rm -v {} +
        echo "Files deleted."
    else
        echo "Cancelled."
    fi
}

delete_menu() {
    echo "Delete Options:"
    echo "1. Delete a single file"
    echo "2. Delete all files in a folder"
    echo "3. Delete files by extension"
    read -p "Choose an option: " option

    case $option in
        1) delete_file ;;
        2) delete_all_in_folder ;;
        3) delete_by_extension ;;
        *) echo "Invalid option" ;;
    esac
}

delete_menu
