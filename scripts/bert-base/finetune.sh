TASK=$1
SEED=$2
LAYERS_TO_FINE_TUNE="${@:3}"

OUTPUT_DIR=models/bert-base/$TASK/${LAYERS_TO_FINE_TUNE// /_}/$SEED
mkdir -p $OUTPUT_DIR

LOG_FILE_DIR=logs/bert-base/$TASK/
mkdir -p $LOG_FILE_DIR

echo "TASK: "$TASK
echo "SEED: "$SEED
echo "LAYERS_TO_FINE_TUNE: "$LAYERS_TO_FINE_TUNE
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
    MM_OUTPUT_DIR=models/bert-base/$TASK-MM/${LAYERS_TO_FINE_TUNE// /_}/$SEED
    MM_LOG_FILE_DIR=logs/bert-base/$TASK-MM/
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
python examples/run_glue.py \
  --model_type bert \
  --model_name_or_path $TRAINED_MODEL_DIR/bert-base-uncased \
  --task_name $TASK \
  --do_train \
  --do_eval \
  --do_lower_case \
  --data_dir $DATA_DIR/glue/$TASK/ \
  --max_seq_length 128 \
  --per_gpu_train_batch_size 24 \
  --learning_rate 2e-5 \
  --num_train_epochs 3.0 \
  --save_steps 500 \
  --seed $SEED \
  --layers_to_fine_tune $LAYERS_TO_FINE_TUNE \
  --output_dir $OUTPUT_DIR \
  --overwrite_output_dir

echo "RESULTS"

for METRIC in "${METRICS[@]}"
do
    RESULT=$(cat $OUTPUT_DIR/eval_results.txt | grep $METRIC" =" | rev | cut -d" " -f1 | rev)

    echo $METRIC" = "$RESULT

    LOG_FILE=$LOG_FILE_DIR/${LAYERS_TO_FINE_TUNE// /_}-$METRIC.txt
    touch $LOG_FILE

    echo -e "$SEED\t$RESULT" >> $LOG_FILE
done

if [ $TASK == "MNLI" ]
then
    echo "RESULTS-MM"

    for METRIC in "${METRICS[@]}"
    do
        RESULT=$(cat $MM_OUTPUT_DIR/eval_results.txt | grep $METRIC" =" | rev | cut -d" " -f1 | rev)

        echo "RESULTS"
        echo $METRIC" = "$RESULT

        LOG_FILE=$MM_LOG_FILE_DIR/${LAYERS_TO_FINE_TUNE// /_}-$METRIC.txt
        touch $LOG_FILE
        echo -e "$SEED\t$RESULT" >> $LOG_FILE
    done
fi
