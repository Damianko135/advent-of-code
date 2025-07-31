#!/usr/bin/env bash

declare -A wires
instructions=()

# Read all input lines into instructions array
while IFS= read -r line; do
    instructions+=("$line")
done

while :; do
    all_set=true

    for line in "${instructions[@]}"; do
        # parse line: remove arrow and split
        line=${line//->/}
        IFS=' ' read -ra parts <<< "$line"

        case "${#parts[@]}" in
            2)
                value=${parts[0]}
                wire=${parts[1]}

                # Resolve value if wire
                if [[ $value =~ ^[a-z]+$ ]]; then
                    if [[ -z ${wires[$value]} ]]; then
                        all_set=false
                        continue
                    else
                        value=${wires[$value]}
                    fi
                fi

                # If wire already has value, skip
                if [[ -z ${wires[$wire]} ]]; then
                    wires[$wire]=$value
                    echo "$wire: $value"
                fi
                ;;
            3)
                op=${parts[0]}
                val=${parts[1]}
                wire=${parts[2]}

                if [[ $val =~ ^[a-z]+$ ]]; then
                    if [[ -z ${wires[$val]} ]]; then
                        all_set=false
                        continue
                    else
                        val=${wires[$val]}
                    fi
                fi

                if [[ -z ${wires[$wire]} ]]; then
                    case "$op" in
                        NOT) wires[$wire]=$(( ~val & 0xFFFF )) ;;
                        *) echo "Unknown op: $op" >&2 ;;
                    esac
                    echo "$wire: ${wires[$wire]}"
                fi
                ;;
            4)
                val1=${parts[0]}
                op=${parts[1]}
                val2=${parts[2]}
                wire=${parts[3]}

                # Resolve val1
                if [[ $val1 =~ ^[a-z]+$ ]]; then
                    if [[ -z ${wires[$val1]} ]]; then
                        all_set=false
                        continue
                    else
                        val1=${wires[$val1]}
                    fi
                fi

                # Resolve val2
                if [[ $val2 =~ ^[a-z]+$ ]]; then
                    if [[ -z ${wires[$val2]} ]]; then
                        all_set=false
                        continue
                    else
                        val2=${wires[$val2]}
                    fi
                fi

                if [[ -z ${wires[$wire]} ]]; then
                    case "$op" in
                        AND) wires[$wire]=$(( val1 & val2 )) ;;
                        OR) wires[$wire]=$(( val1 | val2 )) ;;
                        LSHIFT) wires[$wire]=$(( val1 << val2 )) ;;
                        RSHIFT) wires[$wire]=$(( val1 >> val2 )) ;;
                        *) echo "Unknown op: $op" >&2 ;;
                    esac
                    echo "$wire: ${wires[$wire]}"
                fi
                ;;
            *)
                echo "Invalid line: $line" >&2
                ;;
        esac
    done

    # If after full pass no new wire is assigned (all_set is true), break
    $all_set && break
done
