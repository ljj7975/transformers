#!/bin/bash
#SBATCH --account=def-lilimou
#SBATCH --time=0-18:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=roberta-large-MNLI-base.out
#SBATCH --mem=64G

conda activate brandon_bert

TASK='MNLI'
SEED=$1

bash scripts/roberta-large/finetune.sh $TASK "BASE" $SEED
