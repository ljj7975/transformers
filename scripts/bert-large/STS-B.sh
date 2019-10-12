#!/bin/bash
#SBATCH --time=0-06:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --mem=8G

source ~/ENV/bin/activate

TASK='STS-B'
SEED=$1

bash scripts/bert-base/finetune.sh $TASK $SEED 23

bash scripts/bert-base/finetune.sh $TASK $SEED 23 22

bash scripts/bert-base/finetune.sh $TASK $SEED 23 22 21

bash scripts/bert-base/finetune.sh $TASK $SEED 23 22 21 20

bash scripts/bert-base/finetune.sh $TASK $SEED 23 22 21 20 19

bash scripts/bert-base/finetune.sh $TASK $SEED 23 22 21 20 19 18

bash scripts/bert-base/finetune.sh $TASK $SEED 23 22 21 20 19 18 17

bash scripts/bert-base/finetune.sh $TASK $SEED 23 22 21 20 19 18 17 16

bash scripts/bert-base/finetune.sh $TASK $SEED 23 22 21 20 19 18 17 16 15

bash scripts/bert-base/finetune.sh $TASK $SEED 23 22 21 20 19 18 17 16 15 14

bash scripts/bert-base/finetune.sh $TASK $SEED 23 22 21 20 19 18 17 16 15 14 13

bash scripts/bert-base/finetune.sh $TASK $SEED 23 22 21 20 19 18 17 16 15 14 13 12


deactivate
