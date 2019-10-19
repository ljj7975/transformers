#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=3-00:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=baseline-xlnet-base-MNLI_3.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='MNLI'
SEED=$1

bash scripts/glue_scripts/baseline/xlnet-base.sh $TASK $SEED 3e-5

deactivate
