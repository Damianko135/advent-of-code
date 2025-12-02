#!/usr/bin/env bash

echo "This is part 1"

start=50
zero_count=0
file_name="input.txt"

turn_left() {
    local amount=$1
    start=$(( (start - amount) % 100 ))
    (( start < 0 )) && start=$(( start + 100 ))
}

turn_right() {
    local amount=$1
    start=$(( (start + amount) % 100 ))
}

process_line() {
    local line="$1"
    local dir="${line:0:1}"
    local dist="${line:1}"

    case "$dir" in
        L) turn_left "$dist" ;;
        R) turn_right "$dist" ;;
        *) echo "Unknown direction: $dir" ;;
    esac

    (( start == 0 )) && (( zero_count++ ))
}

main() {
    if [[ ! -f "$file_name" ]]; then
        echo "$file_name does not exist."
        exit 1
    fi

    while read -r line; do
        process_line "$line"
    done < "$file_name"

    echo "Final code value: $zero_count"
}

main
