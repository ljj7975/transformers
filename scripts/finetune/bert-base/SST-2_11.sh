#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=0-03:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=bert-base-SST-2_11.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='SST-2'
SEED=$1

bash scripts/glue_scripts/finetune/bert-base.sh $TASK 'FT' $SEED 1e-5 11

deactivate
