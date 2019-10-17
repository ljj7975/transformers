#!/bin/bash
#SBATCH --account=def-lilimou
#SBATCH --time=1-00:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=baseline-bert-large-QQP_2.out
#SBATCH --mem=64G



TASK='QQP'
SEED=$1

bash scripts/baseline/bert-large.sh $TASK $SEED 2e-5


