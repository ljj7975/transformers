#!/bin/bash
#SBATCH --account=def-lilimou
#SBATCH --time=1-00:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=baseline-roberta-large-SST-2_4.out
#SBATCH --mem=64G



TASK='SST-2'
SEED=$1

bash scripts/baseline/roberta-large.sh $TASK $SEED 4e-5


