#!/bin/bash
#SBATCH --time=0-18:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=bert-large-QNLI-large.out
#SBATCH --mem=64G



TASK='QNLI'
SEED=$1

bash scripts/bert-large/finetune.sh $TASK "BASE" $SEED


