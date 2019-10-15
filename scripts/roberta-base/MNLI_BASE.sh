#!/bin/bash
#SBATCH --account=def-lilimou
#SBATCH --time=0-08:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=roberta-base-MNLI-base.out
#SBATCH --mem=64G

conda activate brandon_bert

TASK='MNLI'
SEED=$1

bash scripts/roberta-base/finetune.sh $TASK "BASE" $SEED
