#!/bin/bash
#SBATCH --account=def-lilimou
#SBATCH --time=0-4:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=roberta-large-RTE-all.out
#SBATCH --mem=64G

conda activate brandon_bert

TASK='RTE'
SEED=$1

bash scripts/roberta-large/finetune.sh $TASK "NONE" $SEED

bash scripts/roberta-large/finetune.sh $TASK "BASE" $SEED

bash scripts/roberta-large/finetune.sh $TASK "FT" $SEED 23

bash scripts/roberta-large/finetune.sh $TASK "FT" $SEED 23 22

bash scripts/roberta-large/finetune.sh $TASK "FT" $SEED 23 22 21

bash scripts/roberta-large/finetune.sh $TASK "FT" $SEED 23 22 21 20

bash scripts/roberta-large/finetune.sh $TASK "FT" $SEED 23 22 21 20 19

bash scripts/roberta-large/finetune.sh $TASK "FT" $SEED 23 22 21 20 19 18

bash scripts/roberta-large/finetune.sh $TASK "FT" $SEED 23 22 21 20 19 18 17

bash scripts/roberta-large/finetune.sh $TASK "FT" $SEED 23 22 21 20 19 18 17 16

bash scripts/roberta-large/finetune.sh $TASK "FT" $SEED 23 22 21 20 19 18 17 16 15

bash scripts/roberta-large/finetune.sh $TASK "FT" $SEED 23 22 21 20 19 18 17 16 15 14

bash scripts/roberta-large/finetune.sh $TASK "FT" $SEED 23 22 21 20 19 18 17 16 15 14 13

bash scripts/roberta-large/finetune.sh $TASK "FT" $SEED 23 22 21 20 19 18 17 16 15 14 13 12
