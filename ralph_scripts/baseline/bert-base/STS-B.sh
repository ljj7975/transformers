#!/bin/bash
#SBATCH --account=def-lilimou
#SBATCH --time=0-04:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=baseline-bert-base-STS-B.out
#SBATCH --mem=64G



TASK='STS-B'
SEED=$1

bash scripts/baseline/bert-base.sh $TASK $SEED 1e-5

bash scripts/baseline/bert-base.sh $TASK $SEED 2e-5

bash scripts/baseline/bert-base.sh $TASK $SEED 3e-5

bash scripts/baseline/bert-base.sh $TASK $SEED 4e-5

bash scripts/baseline/bert-base.sh $TASK $SEED 5e-5



