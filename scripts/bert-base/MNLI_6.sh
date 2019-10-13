#!/bin/bash
#SBATCH --time=0-08:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G

source ~/ENV/bin/activate

TASK='MNLI'
SEED=$1

bash scripts/bert-base/finetune.sh $TASK "FT" $SEED 11 10 9 8 7 6

deactivate
