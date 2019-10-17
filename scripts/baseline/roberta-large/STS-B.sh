#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=1-00:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=baseline-roberta-large-STS-B.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='STS-B'
SEED=$1

bash scripts/baseline/roberta-large.sh $TASK $SEED 1e-5

bash scripts/baseline/roberta-large.sh $TASK $SEED 2e-5

bash scripts/baseline/roberta-large.sh $TASK $SEED 3e-5

bash scripts/baseline/roberta-large.sh $TASK $SEED 4e-5

bash scripts/baseline/roberta-large.sh $TASK $SEED 5e-5


deactivate
