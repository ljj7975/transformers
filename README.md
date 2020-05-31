# What Would Elsa Do? Freezing Layers During Transformer Fine-Tuning

# Instructions
1. Setup Anaconda environment named `freezing` with python 3.6
2. Clone and install necessary packages
```
pip -r requirements.txt
cd examples
pip -r requirements.txt
cd ..
pip install .
```
3. Download glue dataset
```
python scripts/download_glue_data.py
mkdir /data
mv glue_data /data/glue
```
4. Download pre-trained models
```
mkdir /trained_model
bash download_trained_model.sh
```

# Script Generation

This repo generates scripts for Slurm Workload Manager
Each script contains a python command for running one fine-tuning experiment

To generate scripts use `scripts/generate_scripts.py` script

```
parser.add_argument('--model', '-m', type=str, default='all', choices=['all', 'bert-base', 'bert-large', 'roberta-base', 'roberta-large', 'xlnet-base', 'xlnet-large'])
parser.add_argument("--baseline", action='store_true', help="true to fine-tune the whole network.")
parser.add_argument("--v100", action='store_true', help="Whether it is for v100 or not.")
parser.add_argument("--mt_dnn", action='store_true', help="ture to use mt-dnn weights.")
```

Depending on `--baseline` flags, the scripts are generated under `finetune/` or `baseline/` and organized based on model type and task

Each script is has a form of `<Task-name>_<layers_to_finetune_from>.sh`
where None for `<layers_to_finetune_from>` indicates that only the output layer will be fine-tuned

# Script Generation
Results collected for the paper submission is stored under `exp_results`
and post-processed results are under `finetune_exp`




