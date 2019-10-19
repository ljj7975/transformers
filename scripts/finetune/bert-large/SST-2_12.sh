#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=0-06:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=bert-large-SST-2_12.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='SST-2'
SEED=$1

bash scripts/glue_scripts/finetune/bert-large.sh $TASK 'FT' $SEED 1e-5 23 22 21 20 19 18 17 16 15 14 13 12

deactivate
