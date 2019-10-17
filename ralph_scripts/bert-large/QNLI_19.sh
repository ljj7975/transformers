#!/bin/bash
#SBATCH --time=0-18:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=bert-large-QNLI-19.out
#SBATCH --mem=64G



TASK='QNLI'
SEED=$1

bash scripts/bert-large/finetune.sh $TASK "FT" $SEED 23 22 21 20 19


