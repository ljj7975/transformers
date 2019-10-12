#!/bin/bash
#SBATCH --time=0-08:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --mem=8G

source ~/ENV/bin/activate

TASK='QQP'
SEED=$1

bash scripts/bert-base/finetune.sh $TASK $SEED 11 10

deactivate
