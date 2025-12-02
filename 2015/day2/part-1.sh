#!/usr/bin/env bash

# Function to calculate wrapping paper needed for one box
calc() {
    local length=$1
    local width=$2
    local height=$3
    local side1 side2 side3 slack final_sum

    # Doubled sides
    side1=$(( 2 * length * width ))
    side2=$(( 2 * width * height ))
    side3=$(( 2 * length * height ))

    # Use doubled sides to determine smallest, then divide by 2 for slack
    slack=$side1
    if (( side2 < slack )); then slack=$side2; fi
    if (( side3 < slack )); then slack=$side3; fi
    slack=$(( slack / 2 ))

    # Add all surface area + slack
    final_sum=$(( side1 + side2 + side3 + slack ))

    echo "$final_sum"
}

# Initialize total
total_needed=0

# Read each line in format LxWxH
while IFS=x read -r l w h; do
    sum=$(calc "$l" "$w" "$h")
    (( total_needed += sum ))
done

echo "Total needed = $total_needed"
