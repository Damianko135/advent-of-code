#!/usr/bin/env bash

floor=0
char_count=0
basement_entry=1  # 1 means false, 0 means true

while read -rn1 char; do
    ((char_count++))

    if [[ "$char" == "(" ]]; then
        ((floor++))
    elif [[ "$char" == ")" ]]; then
        ((floor--))
    fi

    if (( floor == -1 && basement_entry == 1 )); then
        first_basement=$char_count
        basement_entry=0
    fi
done

echo "First basement entry at character: $first_basement"
echo "Final floor: $floor"
