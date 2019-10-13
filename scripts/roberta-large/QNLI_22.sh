#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=0-18:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=roberta-large-QNLI-22.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='QNLI'
SEED=$1

bash scripts/roberta-large/finetune.sh $TASK "FT" $SEED 23 22

deactivate
