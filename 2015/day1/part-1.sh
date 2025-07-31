#!/usr/bin/env bash

floor=0
char_count=0
while read -rn1 char; do
    ((char_count++))

    if [[ "$char" == "(" ]]; then
        ((floor++))
    elif [[ "$char" == ")" ]]; then
        ((floor--))
    fi
done

echo "Final floor: $floor"
