#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=0-08:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=baseline-bert-base-MNLI_1.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='MNLI'
SEED=$1

bash scripts/baseline/bert-base.sh $TASK $SEED 1e-5

deactivate
