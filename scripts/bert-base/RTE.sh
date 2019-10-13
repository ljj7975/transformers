#!/bin/bash
#SBATCH --time=0-3:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G

source ~/ENV/bin/activate

TASK='RTE'
SEED=$1

bash scripts/bert-base/finetune.sh $TASK "BASE" $SEED

bash scripts/bert-base/finetune.sh $TASK "NONE" $SEED

bash scripts/bert-base/finetune.sh $TASK "FT" $SEED 11

bash scripts/bert-base/finetune.sh $TASK "FT" $SEED 11 10

bash scripts/bert-base/finetune.sh $TASK "FT" $SEED 11 10 9

bash scripts/bert-base/finetune.sh $TASK "FT" $SEED 11 10 9 8

bash scripts/bert-base/finetune.sh $TASK "FT" $SEED 11 10 9 8 7

bash scripts/bert-base/finetune.sh $TASK "FT" $SEED 11 10 9 8 7 6

deactivate
