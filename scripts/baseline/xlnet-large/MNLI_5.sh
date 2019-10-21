#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=1-00:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=baseline-xlnet-large-MNLI_5.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='MNLI'
SEED=$1

bash scripts/glue_scripts/baseline/xlnet-large.sh $TASK $SEED 5e-5

deactivate
