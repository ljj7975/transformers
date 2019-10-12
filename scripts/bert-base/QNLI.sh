#!/bin/bash
#SBATCH --time=0-12:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --mem=8G

source ~/ENV/bin/activate

TASK='QNLI'
SEED=$1

bash scripts/bert-base/finetune.sh $TASK $SEED 11

bash scripts/bert-base/finetune.sh $TASK $SEED 11 10

bash scripts/bert-base/finetune.sh $TASK $SEED 11 10 9

bash scripts/bert-base/finetune.sh $TASK $SEED 11 10 9 8

bash scripts/bert-base/finetune.sh $TASK $SEED 11 10 9 8 7

bash scripts/bert-base/finetune.sh $TASK $SEED 11 10 9 8 7 6

deactivate
