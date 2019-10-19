#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=1-00:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=bert-large-QQP-none.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='QQP'
SEED=$1

bash scripts/bert-large/finetune.sh $TASK "NONE" $SEED

deactivate
