#!/bin/bash
#SBATCH --account=def-lilimou
#SBATCH --time=0-10:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=roberta-base-QNLI-9.out
#SBATCH --mem=64G

conda activate brandon_bert

TASK='QNLI'
SEED=$1

bash scripts/roberta-base/finetune.sh $TASK "FT" $SEED 11 10 9
