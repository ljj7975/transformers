#!/bin/bash
#SBATCH --time=0-08:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=bert-base-MNLI-none.out
#SBATCH --mem=64G



TASK='MNLI'
SEED=$1

bash scripts/bert-base/finetune.sh $TASK "NONE" $SEED


