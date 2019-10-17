#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=0-03:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=baseline-bert-base-SST-2_2.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='SST-2'
SEED=$1

bash scripts/baseline/bert-base.sh $TASK $SEED 2e-5

deactivate
