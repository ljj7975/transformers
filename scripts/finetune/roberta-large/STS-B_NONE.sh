#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=0-04:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=roberta-large-STS-B_NONE.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='STS-B'
SEED=$1

bash scripts/glue_scripts/finetune/roberta-large.sh 'NONE' $SEED 1e-5 

deactivate
