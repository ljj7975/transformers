#!/bin/bash
#SBATCH --time=0-06:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=bert-large-SST-2-12.out
#SBATCH --mem=64G



TASK='SST-2'
SEED=$1

bash scripts/bert-large/finetune.sh $TASK "FT" $SEED 23 22 21 20 19 18 17 16 15 14 13 12


