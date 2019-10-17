#!/bin/bash
#SBATCH --account=def-lilimou
#SBATCH --time=0-06:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=baseline-bert-large-SST-2_5.out
#SBATCH --mem=64G



TASK='SST-2'
SEED=$1

bash scripts/baseline/bert-large.sh $TASK $SEED 5e-5


