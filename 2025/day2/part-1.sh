#!/usr/bin/env bash

echo "This is part 1"

file="input.txt"


function isInvalid() {
    local id="$1"
    local length=${#id}
    
    # Check if the ID is made of a sequence repeated exactly twice
    # The length must be even
    if (( length % 2 != 0 )); then
        return 1  # Valid (odd length can't be repeated sequence)
    fi
    
    local half=$((length / 2))
    local first_half="${id:0:$half}"
    local second_half="${id:$half:$half}"
    
    if [[ "$first_half" == "$second_half" ]]; then
        return 0  # Invalid (is a repeated sequence)
    fi
    
    return 1  # Valid (not a repeated sequence)
}

function processRange() {
    local range="$1"
    IFS='-' read -ra parts <<< "$range"
    local start="${parts[0]}"
    local end="${parts[1]}"
    
    local sum=0
    for ((id = start; id <= end; id++)); do
        if isInvalid "$id"; then
            sum=$((sum + id))
        fi
    done
    
    echo "$sum"
}

function seperateByComma() {
    IFS=',' read -ra ID_RANGES <<< "$1"
    local total=0
    
    for range in "${ID_RANGES[@]}"; do
        local range_sum=$(processRange "$range")
        total=$((total + range_sum))
    done
    
    echo "Total invalid IDs sum: $total"
}


function main() {
    if [[ -f "$file" ]]; then
        while IFS= read -r line || [[ -n $line ]]; do
            seperateByComma "$line"
        done < "$file"
    else
        echo "File not found!"
    fi
}


main