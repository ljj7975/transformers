#!/bin/bash
#SBATCH --account=def-lilimou
#SBATCH --time=4-00:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=baseline-roberta-large-QNLI_5.out
#SBATCH --mem=64G



TASK='QNLI'
SEED=$1

bash scripts/baseline/roberta-large.sh $TASK $SEED 5e-5


