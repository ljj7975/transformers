#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=4-00:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=baseline-roberta-large-QQP_2.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='QQP'
SEED=$1

bash scripts/baseline/roberta-large.sh $TASK $SEED 2e-5

deactivate
