#!/bin/bash
#SBATCH --account=def-lilimou
#SBATCH --time=1-00:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=roberta-large-QQP-22.out
#SBATCH --mem=64G

 

TASK='QQP'
SEED=$1

bash scripts/roberta-large/finetune.sh $TASK "FT" $SEED 23 22


