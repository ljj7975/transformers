#!/bin/bash
#SBATCH --account=def-lilimou
#SBATCH --time=4-00:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=baseline-roberta-large-MNLI_3.out
#SBATCH --mem=64G



TASK='MNLI'
SEED=$1

bash scripts/baseline/roberta-large.sh $TASK $SEED 3e-5


