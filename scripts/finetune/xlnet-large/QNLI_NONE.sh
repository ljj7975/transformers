#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=0-00:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=xlnet-large-QNLI_NONE.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='QNLI'
SEED=$1

bash scripts/glue_scripts/finetune/xlnet-large.sh 'NONE' $SEED 1e-5 

deactivate
