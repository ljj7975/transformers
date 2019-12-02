import argparse
import os
import shutil

TASKS=["CoLA", "SST-2", "MRPC", "STS-B", "QQP", "MNLI", "QNLI", "RTE"]
EXP_TASKS=["QQP", "MNLI", "QNLI"]

time_limit = None

v100_time_limit = {
    "bert-base":{
            "CoLA" : "0-02:00:00",
            "SST-2" : "0-05:00:00",
            "MRPC" : "0-02:00:00",
            "STS-B" : "0-02:00:00",
            "QQP" : "1-10:00:00",
            "MNLI" : "1-10:00:00",
            "QNLI" : "1-00:00:00",
            "RTE" : "0-02:00:00",
            "WNLI" : "0-02:00:00"
        },
    "bert-large":{
            "CoLA" : "0-06:00:00",
            "SST-2" : "0-10:00:00",
            "MRPC" : "0-06:00:00",
            "STS-B" : "0-06:00:00",
            "QQP" : "1-06:00:00",
            "MNLI" : "2-00:00:00",
            "QNLI" : "1-00:00:00",
            "RTE" : "0-03:00:00",
            "WNLI" : "0-03:00:00"
        },
    "roberta-base":{
            "CoLA" : "0-04:00:00",
            "SST-2" : "0-10:00:00",
            "MRPC" : "0-03:00:00",
            "STS-B" : "0-04:00:00",
            "QQP" : "3-00:00:00",
            "MNLI" : "3-00:00:00",
            "QNLI" : "1-00:00:00",
            "RTE" : "0-02:00:00",
            "WNLI" : "0-03:00:00"
        },
    "roberta-large":{
            "CoLA" : "0-10:00:00",
            "SST-2" : "1-05:00:00",
            "MRPC" : "0-10:00:00",
            "STS-B" : "0-10:00:00",
            "QQP" : "4-00:00:00",
            "MNLI" : "4-00:00:00",
            "QNLI" : "4-00:00:00",
            "RTE" : "0-06:00:00",
            "WNLI" : "0-05:00:00"
        },
    "xlnet-base":{
            "CoLA" : "0-03:00:00",
            "SST-2" : "0-06:00:00",
            "MRPC" : "0-02:00:00",
            "STS-B" : "0-02:00:00",
            "QQP" : "0-10:00:00",
            "MNLI" : "0-10:00:00",
            "QNLI" : "0-10:00:00",
            "RTE" : "0-03:00:00",
            "WNLI" : "0-02:00:00"
        },
    "xlnet-large":{
            "CoLA" : "0-08:00:00",
            "SST-2" : "0-06:00:00",
            "MRPC" : "0-05:00:00",
            "STS-B" : "0-04:00:00",
            "QQP" : "1-00:00:00",
            "MNLI" : "1-00:00:00",
            "QNLI" : "1-00:00:00",
            "RTE" : "0-07:00:00",
            "WNLI" : "0-04:00:00"
        }
}

extended_time_limit = {
    "bert-base":{
            "CoLA" : "0-02:00:00",
            "SST-2" : "0-06:00:00",
            "MRPC" : "0-02:00:00",
            "STS-B" : "0-02:00:00",
            "QQP" : "2-12:00:00",
            "MNLI" : "2-12:00:00",
            "QNLI" : "2-00:00:00",
            "RTE" : "0-02:00:00",
            "WNLI" : "0-02:00:00"
        },
    "bert-large":{
            "CoLA" : "0-05:00:00",
            "SST-2" : "0-15:00:00",
            "MRPC" : "0-05:00:00",
            "STS-B" : "0-05:00:00",
            "QQP" : "2-12:00:00",
            "MNLI" : "4-00:00:00",
            "QNLI" : "2-00:00:00",
            "RTE" : "0-05:00:00",
            "WNLI" : "0-02:00:00"
        },
    "roberta-base":{
            "CoLA" : "0-04:00:00",
            "SST-2" : "0-20:00:00",
            "MRPC" : "0-04:00:00",
            "STS-B" : "0-08:00:00",
            "QQP" : "3-10:00:00",
            "MNLI" : "3-10:00:00",
            "QNLI" : "2-20:00:00",
            "RTE" : "0-02:00:00",
            "WNLI" : "0-04:00:00"
        },
    "roberta-large":{
            "CoLA" : "0-10:00:00",
            "SST-2" : "2-00:00:00",
            "MRPC" : "0-10:00:00",
            "STS-B" : "0-10:00:00",
            "QQP" : "8-00:00:00",
            "MNLI" : "8-00:00:00",
            "QNLI" : "8-00:00:00",
            "RTE" : "0-10:00:00",
            "WNLI" : "0-06:00:00"
        },
    "xlnet-base":{
            "CoLA" : "0-06:00:00",
            "SST-2" : "0-12:00:00",
            "MRPC" : "0-04:00:00",
            "STS-B" : "0-04:00:00",
            "QQP" : "0-20:00:00",
            "MNLI" : "0-20:00:00",
            "QNLI" : "0-20:00:00",
            "RTE" : "0-06:00:00",
            "WNLI" : "0-04:00:00"
        },
    "xlnet-large":{
            "CoLA" : "0-14:00:00",
            "SST-2" : "0-12:00:00",
            "MRPC" : "0-10:00:00",
            "STS-B" : "0-08:00:00",
            "QQP" : "2-00:00:00",
            "MNLI" : "2-00:00:00",
            "QNLI" : "2-00:00:00",
            "RTE" : "0-14:00:00",
            "WNLI" : "0-08:00:00"
        }
}

learning_rate = {
    "bert-base":{
            "CoLA" : "4",
            "SST-2" : "2",
            "MRPC" : "3",
            "STS-B" : "5",
            "QQP" : "2",
            "MNLI" : "3",
            "QNLI" : "2",
            "RTE" : "3",
            "WNLI" : "3"
        },
    "bert-large":{
            "CoLA" : "2",
            "SST-2" : "1",
            "MRPC" : "2",
            "STS-B" : "4",
            "QQP" : "1",
            "MNLI" : "1",
            "QNLI" : "2",
            "RTE" : "3",
            "WNLI" : "2"
        },
    "roberta-base":{
            "CoLA" : "4",
            "SST-2" : "1",
            "MRPC" : "2",
            "STS-B" : "2",
            "QQP" : "1",
            "MNLI" : "1",
            "QNLI" : "1",
            "RTE" : "3",
            "WNLI" : "5"
        },
    "roberta-large":{
            "CoLA" : "1",
            "SST-2" : "1",
            "MRPC" : "1",
            "STS-B" : "2",
            "QQP" : "1",
            "MNLI" : "1",
            "QNLI" : "1",
            "RTE" : "1",
            "WNLI" : "3"
        },
    "xlnet-base":{
            "CoLA" : "2",
            "SST-2" : "1",
            "MRPC" : "1",
            "STS-B" : "2",
            "QQP" : "3",
            "MNLI" : "2",
            "QNLI" : "2",
            "RTE" : "1",
            "WNLI" : "5"
        },
    "xlnet-large":{
            "CoLA" : "1",
            "SST-2" : "1",
            "MRPC" : "1",
            "STS-B" : "2",
            "QQP" : "1",
            "MNLI" : "1",
            "QNLI" : "1",
            "RTE" : "1",
            "WNLI" : "5"
        }
}


def generate_dir(dir_path):
    if not os.path.exists(dir_path):
        os.makedirs(dir_path)


def generate_base_script(model, v100):
    print(model, "baseline")
    gpu_type = "v100:" if v100 else ""

    baseline_dir = "baseline"
    generate_dir(baseline_dir)

    model_dir = f"{baseline_dir}/{model}"

    if os.path.exists(model_dir):
        shutil.rmtree(model_dir)

    generate_dir(model_dir)

    for task in TASKS:
        for lr in range(1,6):
            lines = [
                "#!/bin/bash\n",
                "#SBATCH --account=def-jimmylin\n",
                f"#SBATCH --time={time_limit[model][task]}\n",
                f"#SBATCH --gres=gpu:{gpu_type}1\n",
                "#SBATCH --cpus-per-task=4\n",
                f"#SBATCH --output=baseline-{model}-{task}_{lr}.out\n",
                "#SBATCH --mem=64G\n",
                "\n",
                "source ~/anaconda3/etc/profile.d/conda.sh\n",
                "conda activate brandon_bert\n",
                "\n",
                f"TASK=\'{task}\'\n",
                "SEED=$1\n",
                "\n",
                f"bash scripts/glue_scripts/baseline/{model}.sh $TASK $SEED {lr}e-5\n",
                "\n"
            ]

            file_name = f"{model_dir}/{task}_{lr}.sh"
            file = open(file_name, "w")

            file.writelines(lines)


def generate_finetune_script(model, v100, mt_dnn):
    gpu_type = "v100:" if v100 else ""

    if mt_dnn:
        baseline_dir = "mt_dnn_finetune"
        mt_dnn_arg = "TRUE"
    else:
        baseline_dir = "finetune"
        mt_dnn_arg = "FALSE"

    print(model, baseline_dir, gpu_type, mt_dnn_arg)

    generate_dir(baseline_dir)

    model_dir = f"{baseline_dir}/{model}"

    if os.path.exists(model_dir):
        shutil.rmtree(model_dir)

    generate_dir(model_dir)

    exp_model_dir = f"{model_dir}/exp"
    mid_model_dir = f"{model_dir}/mid"
    cheap_model_dir = f"{model_dir}/cheap"

    generate_dir(exp_model_dir)
    generate_dir(mid_model_dir)
    generate_dir(cheap_model_dir)

    if "base" in model:
        layers = list(range(6, 12))
    else:
        layers = list(range(12, 24))

    for task in TASKS:
        layer_str = ""

        num_gpu = 1
        if task in EXP_TASKS:
            num_gpu = 2

        for layer in reversed(layers):
            layer_str = layer_str + f" {layer}"

            lines = [
                "#!/bin/bash\n",
                "#SBATCH --account=def-jimmylin\n",
                f"#SBATCH --time={time_limit[model][task]}\n",
                f"#SBATCH --gres=gpu:{gpu_type}{num_gpu}\n",
                "#SBATCH --cpus-per-task=4\n",
                f"#SBATCH --output={model}-{task}_{layer}.out\n",
                "#SBATCH --mem=64G\n",
                "\n",
                "source ~/anaconda3/etc/profile.d/conda.sh\n",
                "conda activate brandon_bert\n",
                "\n",
                f"TASK=\'{task}\'\n",
                "SEED=$1\n",
                "\n",
                f"bash scripts/glue_scripts/finetune/{model}.sh $TASK {mt_dnn_arg} \'FT\' $SEED {learning_rate[model][task]}e-5{layer_str}\n",
                "\n"
            ]

            if task in EXP_TASKS:
                file_name = f"{exp_model_dir}/{task}_{layer}.sh"

            elif layer in list(range(12,19)):
                file_name = f"{mid_model_dir}/{task}_{layer}.sh"
            else:
                file_name = f"{cheap_model_dir}/{task}_{layer}.sh"

            file = open(file_name, "w")

            file.writelines(lines)

        # -- base --


        layer_str = layer_str + f" BASE"

        lines = [
            "#!/bin/bash\n",
            "#SBATCH --account=def-jimmylin\n",
            f"#SBATCH --time={time_limit[model][task]}\n",
            f"#SBATCH --gres=gpu:{gpu_type}{num_gpu}\n",
            "#SBATCH --cpus-per-task=4\n",
            f"#SBATCH --output={model}-{task}_BASE.out\n",
            "#SBATCH --mem=64G\n",
            "\n",
            "source ~/anaconda3/etc/profile.d/conda.sh\n",
            "conda activate brandon_bert\n",
            "\n",
            f"TASK=\'{task}\'\n",
            "SEED=$1\n",
            "\n",
            f"bash scripts/glue_scripts/finetune/{model}.sh $TASK {mt_dnn_arg} \'BASE\' $SEED {learning_rate[model][task]}e-5 \n",
            "\n"
        ]

        if task in EXP_TASKS:
            file_name = f"{exp_model_dir}/{task}_BASE.sh"
        else:
            file_name = f"{mid_model_dir}/{task}_BASE.sh"

        file = open(file_name, "w")

        file.writelines(lines)


        # -- none --


        layer_str = layer_str + f" NONE"

        lines = [
            "#!/bin/bash\n",
            "#SBATCH --account=def-jimmylin\n",
            f"#SBATCH --time={time_limit[model][task]}\n",
            f"#SBATCH --gres=gpu:{gpu_type}{num_gpu}\n",
            "#SBATCH --cpus-per-task=4\n",
            f"#SBATCH --output={model}-{task}_NONE.out\n",
            "#SBATCH --mem=64G\n",
            "\n",
            "source ~/anaconda3/etc/profile.d/conda.sh\n",
            "conda activate brandon_bert\n",
            "\n",
            f"TASK=\'{task}\'\n",
            "SEED=$1\n",
            "\n",
            f"bash scripts/glue_scripts/finetune/{model}.sh $TASK {mt_dnn_arg} \'NONE\' $SEED {learning_rate[model][task]}e-5 \n",
            "\n"
        ]

        if task in EXP_TASKS:
            file_name = f"{exp_model_dir}/{task}_NONE.sh"
        else:
            file_name = f"{cheap_model_dir}/{task}_NONE.sh"

        file = open(file_name, "w")

        file.writelines(lines)



def main():
    global time_limit

    parser = argparse.ArgumentParser()

    parser.add_argument('--model', '-m', type=str, default='all', choices=['all', 'bert-base', 'bert-large', 'roberta-base', 'roberta-large', 'xlnet-base', 'xlnet-large'])

    parser.add_argument("--baseline", action='store_true', help="Whether to run training.")

    parser.add_argument("--v100", action='store_true', help="Whether it is for v100 or not.")

    parser.add_argument("--mt_dnn", action='store_true', help="ture to use mt-dnn weights.")

    args = parser.parse_args()

    if args.v100:
        time_limit=v100_time_limit
    else:
        time_limit=extended_time_limit

    models = ['bert-base', 'bert-large', 'roberta-base', 'roberta-large', 'xlnet-base', 'xlnet-large']
    if args.model != "all":
        models = [args.model]

    for model in models:
        if args.baseline:
            generate_base_script(model, args.v100)
        else:
            generate_finetune_script(model, args.v100, args.mt_dnn)

if __name__ == "__main__":
    main()
