#!/usr/bin/env bash

naughty_strings=(
    'ab' 
    'cd'
    'pq'
    'xy'
)

input=$(< /dev/stdin)

# Regex to check if double letters exist
double_regex='([a-z])\1'
# Regex atleast 3 vowels
vowel_regex='([aeiou].*){3,}'

while read -r line; do
    # Check for naughty strings
    if [[ "$line" =~ ${naughty_strings[0]} || "$line" =~ ${naughty_strings[1]} || 
          "$line" =~ ${naughty_strings[2]} || "$line" =~ ${naughty_strings[3]} ]]; then
        continue
    fi

    # Check for double letters
    if [[ ! "$line" =~ $double_regex ]]; then
        continue
    fi

    # Check for at least 3 vowels
    if [[ ! "$line" =~ $vowel_regex ]]; then
        continue
    fi

    echo "Nice string: $line"
    ((nice_lists++))
done <<< "$input"

echo "Total nice strings: $nice_lists"


