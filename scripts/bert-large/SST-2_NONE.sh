#!/bin/bash
#SBATCH --time=0-04:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=bert-large-SST-2-none.out
#SBATCH --mem=64G

source ~/ENV/bin/activate

TASK='SST-2'
SEED=$1

bash scripts/bert-large/finetune.sh $TASK "NONE" $SEED

deactivate
