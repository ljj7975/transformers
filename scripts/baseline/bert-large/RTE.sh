#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=0-02:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=baseline-bert-large-RTE.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='RTE'
SEED=$1

bash scripts/baseline/bert-large.sh $TASK $SEED 1e-5

bash scripts/baseline/bert-large.sh $TASK $SEED 2e-5

bash scripts/baseline/bert-large.sh $TASK $SEED 3e-5

bash scripts/baseline/bert-large.sh $TASK $SEED 4e-5

bash scripts/baseline/bert-large.sh $TASK $SEED 5e-5

deactivate
