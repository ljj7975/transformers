#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=0-10:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=roberta-base-QNLI-none.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='QNLI'
SEED=$1

bash scripts/roberta-base/finetune.sh $TASK "NONE" $SEED

deactivate
