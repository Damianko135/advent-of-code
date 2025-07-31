#!/usr/bin/env bash

declare -A grid

santa_x=0
santa_y=0
robo_x=0
robo_y=0

FATAL() {
	echo "[FATAL] $@"
	exit 1
}

move_santa() {
	local char=$1
	case "$char" in
		'^') ((santa_y++)) ;;
		'v') ((santa_y--)) ;;
		'>') ((santa_x++)) ;;
		'<') ((santa_x--)) ;;
		*) FATAL "Unknown direction: $char" ;;
	esac
	grid["$santa_x,$santa_y"]=1
}

move_robo() {
	local char=$1
	case "$char" in
		'^') ((robo_y++)) ;;
		'v') ((robo_y--)) ;;
		'>') ((robo_x++)) ;;
		'<') ((robo_x--)) ;;
		*) FATAL "Unknown direction: $char" ;;
	esac
	grid["$robo_x,$robo_y"]=1
}

# Start by delivering at 0,0
grid["0,0"]=1

step=0
while read -rn1 char; do
	if (( step % 2 == 0 )); then
		move_santa "$char"
	else
		move_robo "$char"
	fi
	((step++))
done

echo "Unique houses visited: ${#grid[@]}"
