#!/bin/bash
dir=$1
seed=$2

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    exit
fi

echo "running scripts under $dir with seed $seed"

for script in "$dir"/*
do
    if [[ $script == *.sh ]]
    then
        echo "sbatch $script $seed"
        sbatch $script $seed
    fi
done