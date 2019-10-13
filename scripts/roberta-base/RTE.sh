#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=0-3:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=roberta-base-RTE-all.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='RTE'
SEED=$1

bash scripts/roberta-base/finetune.sh $TASK "BASE" $SEED

bash scripts/roberta-base/finetune.sh $TASK "NONE" $SEED

bash scripts/roberta-base/finetune.sh $TASK "FT" $SEED 11

bash scripts/roberta-base/finetune.sh $TASK "FT" $SEED 11 10

bash scripts/roberta-base/finetune.sh $TASK "FT" $SEED 11 10 9

bash scripts/roberta-base/finetune.sh $TASK "FT" $SEED 11 10 9 8

bash scripts/roberta-base/finetune.sh $TASK "FT" $SEED 11 10 9 8 7

bash scripts/roberta-base/finetune.sh $TASK "FT" $SEED 11 10 9 8 7 6

deactivate
