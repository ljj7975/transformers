#!/bin/bash
#SBATCH --time=0-04:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=roberta-large-SST-2-14.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='SST-2'
SEED=$1

bash scripts/roberta-large/finetune.sh $TASK "FT" $SEED 23 22 21 20 19 18 17 16 15 14

deactivate
