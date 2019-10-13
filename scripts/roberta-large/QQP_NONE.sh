#!/bin/bash
#SBATCH --time=1-00:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=roberta-large-QQP-none.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='QQP'
SEED=$1

bash scripts/roberta-large/finetune.sh $TASK "NONE" $SEED

deactivate
