#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=0-12:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=xlnet-base-SST-2_10.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='SST-2'
SEED=$1

bash scripts/glue_scripts/finetune/xlnet-base.sh $TASK 'FT' $SEED 1e-5 11 10

deactivate
