#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=0-12:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=baseline-xlnet-base-SST-2_3.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='SST-2'
SEED=$1

bash scripts/glue_scripts/baseline/xlnet-base.sh $TASK $SEED 3e-5

deactivate
