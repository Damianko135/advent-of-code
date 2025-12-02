#!/usr/bin/env bash

echo "This is part 2"

file="input.txt"


function isInvalid() {
    local id="$1"
    local length=${#id}
    
    # Check if the ID is made of a sequence repeated at least twice
    # Try all possible sequence lengths (1 to length/2)
    for ((seq_len = 1; seq_len <= length / 2; seq_len++)); do
        # Check if length is divisible by sequence length
        if (( length % seq_len == 0 )); then
            local sequence="${id:0:$seq_len}"
            local is_repeated=true
            
            # Check if the entire ID is this sequence repeated
            for ((i = 0; i < length; i += seq_len)); do
                if [[ "${id:$i:$seq_len}" != "$sequence" ]]; then
                    is_repeated=false
                    break
                fi
            done
            
            if [[ "$is_repeated" == true ]]; then
                return 0  # Invalid (is a repeated sequence)
            fi
        fi
    done
    
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