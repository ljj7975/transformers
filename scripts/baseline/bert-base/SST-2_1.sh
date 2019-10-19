#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=0-03:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=baseline-bert-base-SST-2_1.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='SST-2'
SEED=$1

bash scripts/glue_scripts/baseline/bert-base.sh $TASK $SEED 1e-5

deactivate
