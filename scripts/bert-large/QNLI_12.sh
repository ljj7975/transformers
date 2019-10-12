#!/bin/bash
#SBATCH --time=0-18:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --mem=8G

source ~/ENV/bin/activate

TASK='QNLI'
SEED=$1

bash scripts/bert-large/finetune.sh $TASK $SEED 23 22 21 20 19 18 17 16 15 14 13 12

deactivate
