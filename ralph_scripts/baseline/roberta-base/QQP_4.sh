#!/bin/bash
#SBATCH --account=def-lilimou
#SBATCH --time=1-00:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=baseline-roberta-base-QQP_4.out
#SBATCH --mem=64G



TASK='QQP'
SEED=$1

bash scripts/baseline/roberta-base.sh $TASK $SEED 4e-5


