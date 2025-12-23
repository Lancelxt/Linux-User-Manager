#!/bin/bash

LOG_FILE="./logs/user_manager.log"
mkdir -p logs

# Log function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# List users
list_users() {
    cut -d: -f1 /etc/passwd
}

# Add user
add_user() {
    read -p "Enter username: " username
    read -p "Enter shell [/bin/bash]: " shell
    shell=${shell:-/bin/bash}

    if id "$username" &>/dev/null; then
        echo "User already exists!"
        log "Failed to add user: $username (already exists)"
    else
        sudo useradd -m -s "$shell" "$username"
        echo "User $username added."
        log "Added user: $username with shell $shell"
    fi
}

# Delete user
delete_user() {
    read -p "Enter username to delete: " username
    if id "$username" &>/dev/null; then
        sudo userdel -r "$username"
        echo "User $username deleted."
        log "Deleted user: $username"
    else
        echo "User does not exist!"
        log "Failed to delete user: $username (not found)"
    fi
}

# Modify user
modify_user() {
    read -p "Enter username to modify: " username
    if ! id "$username" &>/dev/null; then
        echo "User does not exist!"
        log "Failed to modify user: $username (not found)"
        return
    fi

    read -p "Change shell? (y/n): " ch_shell
    if [[ "$ch_shell" == "y" ]]; then
        read -p "Enter new shell [/bin/bash]: " shell
        shell=${shell:-/bin/bash}
        sudo usermod -s "$shell" "$username"
        echo "Shell changed to $shell"
        log "Changed shell for $username to $shell"
    fi

    read -p "Change password? (y/n): " ch_pass
    if [[ "$ch_pass" == "y" ]]; then
        sudo passwd "$username"
        log "Password changed for $username"
    fi
}

# CLI menu
while true; do
    echo "===== Linux User Manager ====="
    echo "1) List users"
    echo "2) Add user"
    echo "3) Delete user"
    echo "4) Modify user"
    echo "5) Exit"
    read -p "Choose an option: " choice

    case $choice in
        1) list_users ;;
        2) add_user ;;
        3) delete_user ;;
        4) modify_user ;;
        5) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option";;
    esac
    echo ""
done
