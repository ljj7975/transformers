#!/bin/bash
#SBATCH --time=0-02:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --mem=8G

source ~/ENV/bin/activate

TASK='MRPC'
SEED=$1

bash fine_tune.sh $TASK $SEED 11

bash fine_tune.sh $TASK $SEED 11 10

bash fine_tune.sh $TASK $SEED 11 10 9

bash fine_tune.sh $TASK $SEED 11 10 9 8

bash fine_tune.sh $TASK $SEED 11 10 9 8 7

bash fine_tune.sh $TASK $SEED 11 10 9 8 7 6

deactivate
