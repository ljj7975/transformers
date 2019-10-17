#!/bin/bash
#SBATCH --account=def-lilimou
#SBATCH --time=1-00:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=baseline-roberta-base-QNLI_5.out
#SBATCH --mem=64G



TASK='QNLI'
SEED=$1

bash scripts/baseline/roberta-base.sh $TASK $SEED 5e-5


