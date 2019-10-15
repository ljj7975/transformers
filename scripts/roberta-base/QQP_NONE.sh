#!/bin/bash
#SBATCH --account=def-lilimou
#SBATCH --time=0-10:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=roberta-base-QQP-none.out
#SBATCH --mem=64G

conda activate brandon_bert

TASK='QQP'
SEED=$1

bash scripts/roberta-base/finetune.sh $TASK "NONE" $SEED
