#!/usr/bin/env bash

# Use a regular indexed array for the grid
lights=()

function parse_instruction() {
    local instruction="$1"
    local action start_x start_y end_x end_y

    # Use awk to parse the instruction (note: unified action string)
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
                    lights[$idx]=1
                    ;;
                turn_off)
                    lights[$idx]=0
                    ;;
                toggle)
                    if [[ ${lights[$idx]:-0} -eq 1 ]]; then
                        lights[$idx]=0
                    else
                        lights[$idx]=1
                    fi
                    ;;
            esac
        done
    done
}

# Read instructions from input
while IFS= read -r line; do
    parse_instruction "$line"
done < "input.txt"

# Count the lights that are on
on_count=0
for idx in "${!lights[@]}"; do
    if [[ ${lights[$idx]} -eq 1 ]]; then
        ((on_count++))
    fi
done

echo "Number of lights on: $on_count"
