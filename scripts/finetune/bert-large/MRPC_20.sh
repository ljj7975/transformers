#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=0-01:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=bert-large-MRPC_20.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='MRPC'
SEED=$1

bash scripts/glue_scripts/finetune/bert-large.sh $TASK 'FT' $SEED 1e-5 23 22 21 20

deactivate
