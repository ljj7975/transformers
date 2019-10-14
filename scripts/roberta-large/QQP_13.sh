#!/bin/bash
#SBATCH --account=def-lilimou
#SBATCH --time=1-00:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=roberta-large-QQP-13.out
#SBATCH --mem=64G

conda activate brandon_bert

TASK='QQP'
SEED=$1

bash scripts/roberta-large/finetune.sh $TASK "FT" $SEED 23 22 21 20 19 18 17 16 15 14 13
