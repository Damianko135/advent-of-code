#!/usr/bin/env bash

naughty_strings=(

)

input=$(< /dev/stdin)

nice_lists=0

# Check for double letters, twice, without overlapping
double_regex='([a-z]{2}).*\1'

# Check for at least one letter that repeats with exactly one letter between them
# Example: xyx, abcdefeghi (efe), or even aaa.
repeat_regex='([a-z]).\1'

while read -r line; do
    # Check for double letters, twice, without overlapping
    if [[ ! "$line" =~ $double_regex ]]; then
        continue
    fi
    # Check for at least one letter that repeats with exactly one letter between them
    if [[ ! "$line" =~ $repeat_regex ]]; then
        continue
    fi
    echo "Nice string: $line"
    ((nice_lists++))
done <<< "$input"

echo "Total nice strings: $nice_lists"


