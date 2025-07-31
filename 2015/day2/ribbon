#!/usr/bin/env bash

calc() {
	local l
	local w
	local h
	l=$1
	w=$2
	h=$3
	# Imma cheat and use sort:
	sorted=($(printf "%s\n" "$l" "$w" "$h" | sort -n))
	extra=$(( (${sorted[0]} + ${sorted[1]}) * 2 ))
	cubic=$(( $l * $w * $h ))
	total=$((extra + cubic))
	echo $total
}





while IFS=x read -r l w h; do
	returned_value=$(calc $l $w $h)
	ribbon_total=$((ribbon_total + returned_value))
done

echo "Total ribbon length: $ribbon_total"
