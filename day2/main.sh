#!/bin/bash

reds=12
greens=13
blues=14
res=0
res_2=0
while IFS= read -r line; do
    game_id=$(echo $line | awk '{print $2}' | tr -d ":")
    IFS=";"
    read -ra hands <<< "$line"
    possible=true
    min_red=0
    min_green=0
    min_blue=0
    for hand in "${hands[@]}"; do
        # Check reds
        if [[ $hand =~ ([0-9]+)\ red ]]; then
            result="${BASH_REMATCH[1]}"
            if [ "$result" -gt "$reds" ]; then
                possible=false
            fi
            if [ "$result" -gt "$min_red" ]; then
                min_red=$result
            fi
        fi
        # Check greens
        if [[ $hand =~ ([0-9]+)\ green ]]; then
            result="${BASH_REMATCH[1]}"
            if [ "$result" -gt "$greens" ]; then
                possible=false
            fi
            if [ "$result" -gt "$min_green" ]; then
                min_green=$result
            fi
        fi
        # Check blues
        if [[ $hand =~ ([0-9]+)\ blue ]]; then
            result="${BASH_REMATCH[1]}"
            if [ "$result" -gt "$blues" ]; then
                possible=false
            fi
            if [ "$result" -gt "$min_blue" ]; then
                min_blue=$result
            fi
        fi
    done
    if [ "$possible" = true ]; then
        res=$((res + game_id))
    fi
    res_2_power=$((min_red * min_green * min_blue))
    res_2=$((res_2 + res_2_power))
done < "input.txt"
echo "Part 1: $res"
echo "Part 2: $res_2"
