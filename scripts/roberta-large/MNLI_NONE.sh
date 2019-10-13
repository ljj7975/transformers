#!/bin/bash
#SBATCH --time=0-18:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=roberta-large-MNLI-none.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='MNLI'
SEED=$1

bash scripts/roberta-large/finetune.sh $TASK "NONE" $SEED

deactivate
