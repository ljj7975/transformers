#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=0-01:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=baseline-roberta-base-RTE_3.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='RTE'
SEED=$1

bash scripts/glue_scripts/baseline/roberta-base.sh $TASK $SEED 3e-5

deactivate
