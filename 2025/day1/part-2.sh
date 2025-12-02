#!/usr/bin/env bash

echo "This is part 2"

start=50
zero_count=0
zero_visits=()
file_name="input.txt"

turn_left() {
    local amount=$1
    for (( i = 0; i < amount; i++ )); do
        start=$(( (start - 1) % 100 ))
        (( start < 0 )) && start=$(( start + 100 ))
        if (( start == 0 )); then
            zero_count=$((zero_count + 1))
            zero_visits+=("Visit $zero_count: Touched 0 via left rotation")
        fi
    done
}

turn_right() {
    local amount=$1
    for (( i = 0; i < amount; i++ )); do
        start=$(( (start + 1) % 100 ))
        if (( start == 0 )); then
            zero_count=$((zero_count + 1))
            zero_visits+=("Visit $zero_count: Touched 0 via right rotation")
        fi
    done
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
}

main() {
    if [[ ! -f "$file_name" ]]; then
        echo "$file_name does not exist."
        exit 1
    fi

    while read -r line; do
        process_line "$line"
    done < "$file_name"

    echo "All times we touched 0:"
    for visit in "${zero_visits[@]}"; do
        echo "  $visit"
    done
    echo ""
    echo "Total times touched 0: $zero_count"
}

main
