#!/bin/bash
#SBATCH --account=def-lilimou
#SBATCH --time=0-08:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=baseline-bert-base-MNLI_3.out
#SBATCH --mem=64G



TASK='MNLI'
SEED=$1

bash scripts/baseline/bert-base.sh $TASK $SEED 3e-5


