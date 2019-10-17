#!/bin/bash
#SBATCH --time=0-10:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=bert-base-QNLI-11.out
#SBATCH --mem=64G



TASK='QNLI'
SEED=$1

bash scripts/bert-base/finetune.sh $TASK "FT" $SEED 11


