TASK=$1
SEED=$2
LR=$3

OUTPUT_DIR=$SCRATCH_DIR/models/baseline/bert-base/$TASK/$SEED
mkdir -p $OUTPUT_DIR

LOG_FILE_DIR=logs/baseline/bert-base/$TASK
mkdir -p $LOG_FILE_DIR

echo "TASK: "$TASK
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
    MM_OUTPUT_DIR=$SCRATCH_DIR/models/baseline/bert-base/$TASK-MM/$SEED
    MM_LOG_FILE_DIR=logs/baseline/bert-base/$TASK-MM
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

MODEL_DIR=$OUTPUT_DIR/$LR

echo "============="
echo "LEARNING_RATE: "$LR
echo "MODEL_DIR: "$MODEL_DIR

python examples/run_glue.py \
  --model_type bert \
  --model_name_or_path $TRAINED_MODEL_DIR/bert-base-uncased \
  --task_name $TASK \
  --do_train \
  --do_eval \
  --do_lower_case \
  --data_dir $DATA_DIR/glue/$TASK/ \
  --max_seq_length 128 \
  --per_gpu_train_batch_size 16 \
  --learning_rate $LR \
  --num_train_epochs 3.0 \
  --save_steps 0 \
  --seed $SEED \
  --output_dir $MODEL_DIR \
  --overwrite_output_dir

for METRIC in "${METRICS[@]}"
do
    RESULT=$(cat $MODEL_DIR/eval_results.txt | grep "^"$METRIC" =" | rev | cut -d" " -f1 | rev)

    echo $METRIC" = "$RESULT

    LOG_FILE=$LOG_FILE_DIR/"${LR}_${METRIC}.txt"
    touch $LOG_FILE
    echo -e "$SEED\t$RESULT" >> $LOG_FILE

    if [ $TASK == "MNLI" ]
    then
        RESULT=$(cat $MM_OUTPUT_DIR/$LR/eval_results.txt | grep "^"$METRIC" =" | rev | cut -d" " -f1 | rev)
        echo "MM :"$METRIC" = "$RESULT

        LOG_FILE=$MM_LOG_FILE_DIR/"${LR}_${METRIC}.txt"
        touch $LOG_FILE
        echo -e "$SEED\t$RESULT" >> $LOG_FILE
    fi
done