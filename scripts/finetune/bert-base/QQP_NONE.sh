#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=0-08:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=bert-base-QQP_NONE.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='QQP'
SEED=$1

bash scripts/glue_scripts/finetune/bert-base.sh 'NONE' $SEED 1e-5 

deactivate
