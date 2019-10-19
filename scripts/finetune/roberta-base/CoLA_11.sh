#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=0-02:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=roberta-base-CoLA_11.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='CoLA'
SEED=$1

bash scripts/glue_scripts/finetune/roberta-base.sh $TASK 'FT' $SEED 1e-5 11

deactivate
