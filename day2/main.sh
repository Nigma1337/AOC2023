#!/bin/bash

solve() {
    if [[ $hand =~ ([0-9]+)\ $1 ]]; then
        result="${BASH_REMATCH[1]}"
        if [ "$result" -gt "$2" ]; then
            possible=false
        fi
        if [ "$result" -gt "$3" ]; then
            # Export is needed here, otherwise bash assume "x=y" is a command
            export min_$1=$result
        fi
    fi
}
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
        solve red $reds $min_red
        # Check greens
        solve green $greens $min_green
        # Check blues
        solve blue $blues $min_blue
    done
    if [ "$possible" = true ]; then
        res=$((res + game_id))
    fi
    res_2_power=$((min_red * min_green * min_blue))
    res_2=$((res_2 + res_2_power))
done < "input.txt"
echo "Part 1: $res"
echo "Part 2: $res_2"
