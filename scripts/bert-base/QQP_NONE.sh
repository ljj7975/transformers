#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=0-10:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=bert-base-QQP-none.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='QQP'
SEED=$1

bash scripts/bert-base/finetune.sh $TASK "NONE" $SEED

deactivate
