#!/bin/bash

manager_menu() {
    echo "=== Folder Manager ==="
    echo "1. Run Utility Script"
    echo "2. Run Read File Script"
    echo "3. Run Delete Script"
    echo "4. Exit"
    read -p "Choose an option: " choice

    case $choice in
        1) bash utility.sh ;;
        2) bash read_file.sh ;;
        3) bash delete.sh ;;
        4) echo "Exiting..." ;;
        *) echo "Invalid option." ;;
    esac
}

while true
do
    manager_menu
done
