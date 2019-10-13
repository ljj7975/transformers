#!/bin/bash
#SBATCH --time=1-00:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G

source ~/ENV/bin/activate

TASK='QQP'
SEED=$1

bash scripts/bert-large/finetune.sh $TASK "NONE" $SEED

deactivate
