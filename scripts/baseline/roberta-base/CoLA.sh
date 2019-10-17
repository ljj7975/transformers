#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=0-10:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=baseline-roberta-base-CoLA.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='CoLA'
SEED=$1

bash scripts/baseline/roberta-base.sh $TASK $SEED 1e-5

bash scripts/baseline/roberta-base.sh $TASK $SEED 2e-5

bash scripts/baseline/roberta-base.sh $TASK $SEED 3e-5

bash scripts/baseline/roberta-base.sh $TASK $SEED 4e-5

bash scripts/baseline/roberta-base.sh $TASK $SEED 5e-5

deactivate


