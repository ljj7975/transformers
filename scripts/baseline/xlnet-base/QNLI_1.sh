#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=0-10:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=baseline-xlnet-base-QNLI_1.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='QNLI'
SEED=$1

bash scripts/glue_scripts/baseline/xlnet-base.sh $TASK $SEED 1e-5

deactivate
