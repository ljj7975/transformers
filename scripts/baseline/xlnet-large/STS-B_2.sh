#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=0-00:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=baseline-xlnet-large-STS-B_2.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='STS-B'
SEED=$1

bash scripts/glue_scripts/baseline/xlnet-large.sh $TASK $SEED 2e-5

deactivate
