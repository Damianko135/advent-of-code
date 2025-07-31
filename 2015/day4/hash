#!/usr/bin/env bash

# example string: abcdef
# example answer: 609043

input=$(< /dev/stdin)

counter=1

while true; do
    input="${input}${counter}"
    hash=$(echo -n "$input" | md5sum | awk '{print $1}')
    
    if [[ "$hash" == 00000* ]]; then
        echo "Found: $counter (hash = $hash)"
        break
    fi
    
    ((counter++))
done

