TASK=$1
MT_DNN=$2
EXP=$3
SEED=$4
LR=$5
LAYERS_TO_FINE_TUNE="${@:6}"

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

if [ $MT_DNN == "TRUE" ]
then
    OUTPUT_DIR=$SCRATCH_DIR/mt_dnn_models/bert-large/$TASK/$LAYER_FOLDER_NAME/$SEED
    LOG_FILE_DIR=mt_dnn_logs/bert-large/$TASK/
else
    OUTPUT_DIR=$SCRATCH_DIR/models/bert-large/$TASK/$LAYER_FOLDER_NAME/$SEED
    LOG_FILE_DIR=logs/bert-large/$TASK/
fi

mkdir -p $OUTPUT_DIR
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
    if [ $MT_DNN == "TRUE" ]
    then
        MM_OUTPUT_DIR=$SCRATCH_DIR/mt_dnn_models/bert-large/$TASK-MM/$LAYER_FOLDER_NAME/$SEED
        MM_LOG_FILE_DIR=mt_dnn_logs/bert-large/$TASK-MM/
    else
        MM_OUTPUT_DIR=$SCRATCH_DIR/models/bert-large/$TASK-MM/$LAYER_FOLDER_NAME/$SEED
        MM_LOG_FILE_DIR=logs/bert-large/$TASK-MM/
    fi
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
if [ $MT_DNN == "TRUE" ]
then
    if [ $EXP == "BASE" ] # no fine tuning
    then
        python examples/run_glue.py \
          --model_type bert \
          --model_name_or_path $TRAINED_MODEL_DIR/bert-large-uncased \
          --mt_model_path $TRAINED_MODEL_DIR/mt-dnn-bert/large.pt \
          --task_name $TASK \
          --do_train \
          --do_eval \
          --do_lower_case \
          --data_dir $DATA_DIR/glue/$TASK/ \
          --max_seq_length 128 \
          --per_gpu_train_batch_size 16 \
          --learning_rate ${LR} \
          --num_train_epochs 3.0 \
          --save_steps 0 \
          --seed $SEED \
          --output_dir $OUTPUT_DIR \
          --overwrite_output_dir
    elif [ $EXP == "FT" ] # fine tune given layers
    then
        python examples/run_glue.py \
          --model_type bert \
          --model_name_or_path $TRAINED_MODEL_DIR/bert-large-uncased \
          --mt_model_path $TRAINED_MODEL_DIR/mt-dnn-bert/large.pt \
          --task_name $TASK \
          --do_train \
          --do_eval \
          --do_lower_case \
          --data_dir $DATA_DIR/glue/$TASK/ \
          --max_seq_length 128 \
          --per_gpu_train_batch_size 16 \
          --learning_rate ${LR} \
          --num_train_epochs 3.0 \
          --save_steps 0 \
          --seed $SEED \
          --layers_to_fine_tune $LAYERS_TO_FINE_TUNE \
          --output_dir $OUTPUT_DIR \
          --overwrite_output_dir
    elif [ $EXP == "NONE" ] # No layers to fine tune (only classifier)
    then
        python examples/run_glue.py \
          --model_type bert \
          --model_name_or_path $TRAINED_MODEL_DIR/bert-large-uncased \
          --mt_model_path $TRAINED_MODEL_DIR/mt-dnn-bert/large.pt \
          --task_name $TASK \
          --do_train \
          --do_eval \
          --do_lower_case \
          --data_dir $DATA_DIR/glue/$TASK/ \
          --max_seq_length 128 \
          --per_gpu_train_batch_size 16 \
          --learning_rate ${LR} \
          --num_train_epochs 3.0 \
          --save_steps 0 \
          --seed $SEED \
          --only_classifier \
          --output_dir $OUTPUT_DIR \
          --overwrite_output_dir
    fi
else
    if [ $EXP == "BASE" ] # no fine tuning
    then
        python examples/run_glue.py \
          --model_type bert \
          --model_name_or_path $TRAINED_MODEL_DIR/bert-large-uncased \
          --task_name $TASK \
          --do_train \
          --do_eval \
          --do_lower_case \
          --data_dir $DATA_DIR/glue/$TASK/ \
          --max_seq_length 128 \
          --per_gpu_train_batch_size 16 \
          --learning_rate ${LR} \
          --num_train_epochs 3.0 \
          --save_steps 0 \
          --seed $SEED \
          --output_dir $OUTPUT_DIR \
          --overwrite_output_dir
    elif [ $EXP == "FT" ] # fine tune given layers
    then
        python examples/run_glue.py \
          --model_type bert \
          --model_name_or_path $TRAINED_MODEL_DIR/bert-large-uncased \
          --task_name $TASK \
          --do_train \
          --do_eval \
          --do_lower_case \
          --data_dir $DATA_DIR/glue/$TASK/ \
          --max_seq_length 128 \
          --per_gpu_train_batch_size 16 \
          --learning_rate ${LR} \
          --num_train_epochs 3.0 \
          --save_steps 0 \
          --seed $SEED \
          --layers_to_fine_tune $LAYERS_TO_FINE_TUNE \
          --output_dir $OUTPUT_DIR \
          --overwrite_output_dir
    elif [ $EXP == "NONE" ] # No layers to fine tune (only classifier)
    then
        python examples/run_glue.py \
          --model_type bert \
          --model_name_or_path $TRAINED_MODEL_DIR/bert-large-uncased \
          --task_name $TASK \
          --do_train \
          --do_eval \
          --do_lower_case \
          --data_dir $DATA_DIR/glue/$TASK/ \
          --max_seq_length 128 \
          --per_gpu_train_batch_size 16 \
          --learning_rate ${LR} \
          --num_train_epochs 3.0 \
          --save_steps 0 \
          --seed $SEED \
          --only_classifier \
          --output_dir $OUTPUT_DIR \
          --overwrite_output_dir
    fi
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
