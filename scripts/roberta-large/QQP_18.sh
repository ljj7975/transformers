#!/bin/bash
#SBATCH --time=1-00:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=roberta-large-QQP-18.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='QQP'
SEED=$1

bash scripts/roberta-large/finetune.sh $TASK "FT" $SEED 23 22 21 20 19 18

deactivate
