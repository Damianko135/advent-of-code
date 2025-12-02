#!/usr/bin/env bash

declare -A grid


x=0
y=0



FATAL() {
	echo "[FATAL] $@"
}


move_santa() {
	local char
	char=$1
	case $char in
		# Which way we going?
  		'^') ((y++)) ;;
  		'v') ((y--)) ;;
  		'>') ((x++)) ;;
  		'<') ((x--)) ;;
		'*') FATAL "unknown character $char" ;;
	esac

}


while read -rn1 char; do
	# The task is saying that the starting is also counted
	key=$x,$y
	grid[$key]=1
	((total_houses++))
	move_santa $char
done

actual_houses=${#grid[@]}
missed_houses=$((total_houses - actual_houses))

echo -e "Got $actual_houses from $total_houses\nMissed $missed_houses houses"