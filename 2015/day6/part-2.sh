#!/usr/bin/env bash

# Use a regular indexed array for the grid
declare -A brightness

function parse_instruction() {
    local instruction="$1"
    local action start_x start_y end_x end_y

    # Use awk to parse the instruction (unified action names)
    read action start_x start_y end_x end_y < <(
        echo "$instruction" | awk '
            /turn on/  {print "turn_on", $3, $4, $6, $7}
            /turn off/ {print "turn_off", $3, $4, $6, $7}
            /toggle/   {print "toggle", $2, $3, $5, $6}
        ' FS='[ ,]'
    )

    for ((x = start_x; x <= end_x; x++)); do
        for ((y = start_y; y <= end_y; y++)); do
            idx=$((x * 1000 + y))
            case $action in
                turn_on)
                    ((brightness[$idx]++))
                    ;;
                turn_off)
                    if (( brightness[$idx] > 0 )); then
                        ((brightness[$idx]--))
                    fi
                    ;;
                toggle)
                    ((brightness[$idx] += 2))
                    ;;
            esac
        done
    done
}

# Read instructions from input
while IFS= read -r line; do
    parse_instruction "$line"
done < "input.txt"

# Sum total brightness
total=0
for val in "${brightness[@]}"; do
    ((total += val))
done

echo "Total brightness: $total"
