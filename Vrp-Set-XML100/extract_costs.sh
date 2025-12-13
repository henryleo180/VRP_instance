#!/bin/bash
cd /blue/yu.yang1/haoran.liu/VRPinstance/Vrp-Set-XML100/solutions
for sol in *.sol; do
    name="${sol%.sol}"
    cost=$(tail -1 "$sol" | grep -o '[0-9]\+')
    vehicles=$(grep -c "^Route #" "$sol")
    echo "$name $cost $vehicles"
done | sort > ../best_solutions.txt
