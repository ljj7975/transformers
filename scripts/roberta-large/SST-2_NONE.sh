#!/bin/bash
#SBATCH --account=def-lilimou
#SBATCH --time=0-04:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=roberta-large-SST-2-none.out
#SBATCH --mem=64G

conda activate brandon_bert

TASK='SST-2'
SEED=$1

bash scripts/roberta-large/finetune.sh $TASK "NONE" $SEED
