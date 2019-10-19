#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=4-00:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=roberta-large-MNLI_NONE.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='MNLI'
SEED=$1

bash scripts/glue_scripts/finetune/roberta-large.sh 'NONE' $SEED 1e-5 

deactivate
