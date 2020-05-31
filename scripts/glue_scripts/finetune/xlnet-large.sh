#!/bin/bash

source ~/anaconda3/etc/profile.d/conda.sh
conda activate freezing
TASK=$1
MT_DNN=$2
EXP=$3
SEED=$4
LR=$5
LAYERS_TO_FINE_TUNE="${@:5}"

if [ $EXP == "BASE" ] # no fine tuning
then
    LAYER_FOLDER_NAME="base"
elif [ $EXP == "FT" ] # fine tune given layers
then
    LAYER_FOLDER_NAME=${LAYERS_TO_FINE_TUNE// /_}
elif [ $EXP == "NONE" ] # No layers to fine tune (only classifier)
then
    LAYER_FOLDER_NAME="no_layer"
else
    echo "Invalid experiment: "$EXP
    exit 1
fi


OUTPUT_DIR=/tmp/models/xlnet-large/$TASK/$LAYER_FOLDER_NAME/$SEED
mkdir -p $OUTPUT_DIR

LOG_FILE_DIR=logs/xlnet-large/$TASK/
mkdir -p $LOG_FILE_DIR

echo "TASK: "$TASK
echo "EXP: "$EXP
echo "SEED: "$SEED
echo "LR: "$LR
echo "OUTPUT_DIR: "$OUTPUT_DIR

# setup metrics
METRICS=()
if [ $TASK == "CoLA" ]
then
    METRICS+=("mcc")
elif [ $TASK == "SST-2" ]
then
    METRICS+=("acc")
elif [ $TASK == "MRPC" ]
then
    METRICS+=("acc" "f1" "acc_and_f1")
elif [ $TASK == "STS-B" ]
then
    METRICS+=("pearson" "spearmanr" "corr")
elif [ $TASK == "QQP" ]
then
    METRICS+=("acc" "f1" "acc_and_f1")
elif [ $TASK == "MNLI" ]
then
    METRICS+=("acc")
    MM_OUTPUT_DIR=/tmp/models/xlnet-large/$TASK-MM/$LAYER_FOLDER_NAME/$SEED
    MM_LOG_FILE_DIR=logs/xlnet-large/$TASK-MM/
    mkdir -p $MM_OUTPUT_DIR
    mkdir -p $MM_LOG_FILE_DIR
elif [ $TASK == "QNLI" ]
then
    METRICS+=("acc")
elif [ $TASK == "RTE" ]
then
    METRICS+=("acc")
elif [ $TASK == "WNLI" ]
then
    METRICS+=("acc")
else
    echo "Invalid task name: "$TASK
    exit 1
fi

# run finetuning

if [ $EXP == "BASE" ] # no fine tuning
then
    python examples/run_glue.py \
      --model_type xlnet \
      --model_name_or_path /trained_model/xlnet-large-cased \
      --task_name $TASK \
      --do_train \
      --do_eval \
      --data_dir /data/glue/$TASK/ \
      --max_seq_length 128 \
      --per_gpu_train_batch_size 16 \
      --learning_rate ${LR} \
      --max_steps 10000 \
      --save_steps 0 \
      --seed $SEED \
      --output_dir $OUTPUT_DIR \
      --overwrite_output_dir
elif [ $EXP == "FT" ] # fine tune given layers
then
    python examples/run_glue.py \
      --model_type xlnet \
      --model_name_or_path /trained_model/xlnet-large-cased \
      --task_name $TASK \
      --do_train \
      --do_eval \
      --data_dir /data/glue/$TASK/ \
      --max_seq_length 128 \
      --per_gpu_train_batch_size 16 \
      --learning_rate ${LR} \
      --max_steps 10000 \
      --save_steps 0 \
      --seed $SEED \
      --layers_to_fine_tune $LAYERS_TO_FINE_TUNE \
      --output_dir $OUTPUT_DIR \
      --overwrite_output_dir
elif [ $EXP == "NONE" ] # No layers to fine tune (only classifier)
then
    python examples/run_glue.py \
      --model_type xlnet \
      --model_name_or_path /trained_model/xlnet-large-cased \
      --task_name $TASK \
      --do_train \
      --do_eval \
      --data_dir /data/glue/$TASK/ \
      --max_seq_length 128 \
      --per_gpu_train_batch_size 16 \
      --learning_rate ${LR} \
      --max_steps 10000 \
      --save_steps 0 \
      --seed $SEED \
      --only_classifier \
      --output_dir $OUTPUT_DIR \
      --overwrite_output_dir
fi

echo "RESULTS"

for METRIC in "${METRICS[@]}"
do
    RESULT=$(cat $OUTPUT_DIR/eval_results.txt | grep "^"$METRIC" =" | rev | cut -d" " -f1 | rev)

    echo $METRIC" = "$RESULT

    LOG_FILE=$LOG_FILE_DIR/$LAYER_FOLDER_NAME-$METRIC.txt
    touch $LOG_FILE

    echo -e "$SEED\t$RESULT" >> $LOG_FILE
done

if [ $TASK == "MNLI" ]
then
    echo "RESULTS-MM"

    for METRIC in "${METRICS[@]}"
    do
        RESULT=$(cat $MM_OUTPUT_DIR/eval_results.txt | grep "^"$METRIC" =" | rev | cut -d" " -f1 | rev)

        echo $METRIC" = "$RESULT

        LOG_FILE=$MM_LOG_FILE_DIR/$LAYER_FOLDER_NAME-$METRIC.txt
        touch $LOG_FILE
        echo -e "$SEED\t$RESULT" >> $LOG_FILE
    done
fi
