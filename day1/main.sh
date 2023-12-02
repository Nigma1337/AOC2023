#!/usr/bin/env bash
echo "$(sed 's/one/o1e/g;s/two/t2o/g;s/three/t3e/g;s/four/f4r/g;s/five/f5e/g;s/six/s6x/g;s/seven/s7n/g;s/eight/e8t/g;s/nine/n9e/g;s/[a-z]//g' input.txt)" | awk '{print substr($0,1,1) substr($0,length,1)}' | awk '{sum+=$1} END {print sum}'
