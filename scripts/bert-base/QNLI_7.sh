#!/bin/bash
#SBATCH --time=0-10:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=bert-base-QNLI-7.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='QNLI'
SEED=$1

bash scripts/bert-base/finetune.sh $TASK "FT" $SEED 11 10 9 8 7

deactivate
