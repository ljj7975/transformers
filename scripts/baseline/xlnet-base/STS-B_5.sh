#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=0-01:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=baseline-xlnet-base-STS-B_5.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='STS-B'
SEED=$1

bash scripts/glue_scripts/baseline/xlnet-base.sh $TASK $SEED 5e-5

deactivate
