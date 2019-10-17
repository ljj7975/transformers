#!/bin/bash
#SBATCH --account=def-lilimou
#SBATCH --time=0-18:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=roberta-large-QNLI-none.out
#SBATCH --mem=64G



TASK='QNLI'
SEED=$1

bash scripts/roberta-large/finetune.sh $TASK "NONE" $SEED


