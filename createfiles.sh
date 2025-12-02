#!/usr/bin/env bash

# Create the files per year for the Advent of Code challenges

max_year=2025
for year in $(seq 2015 $max_year); do
    mkdir -p "$year"
    for day in $(seq 1 25); do
        file_path="$year/day$day"
        mkdir -p "$file_path"
        if [[ -e "$file_path" ]]; then
            touch "$file_path/input.txt"
            touch "$file_path/example.txt"
            touch "$file_path/part-1.sh"
            touch "$file_path/part-2.sh"
            touch "$file_path/README.md"
            echo "# Advent of Code $year - Day $day" > "$file_path/README.md"
        fi
    done
done