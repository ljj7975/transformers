import argparse
import os
import shutil
from pprint import pprint
from pathlib import Path


models=["bert-base", "bert-large", "roberta-base", "roberta-large", "xlnet-base", "xlnet-large"]

tasks = {
    "CoLA":["mcc"],
    "SST-2":["acc"],
    "MRPC":["acc", "f1", "acc_and_f1"],
    "STS-B":["pearson", "spearmanr", "corr"],
    "QQP":["acc", "f1", "acc_and_f1"],
    "MNLI":["acc"],
    "MNLI-MM":["acc"],
    "QNLI":["acc"],
    "RTE":["acc"]
}

def check_results(file_name, target_count):
    if not os.path.exists(file_name):
        print(f"\tFile {file_name} is missing all entries")
        print(f"\tmissing seeds {list(range(1, 6))}")
        return

    seeds = set()

    file = open(file_name, "r")
    lines = file.read().splitlines()
    for line in lines:
        entries = line.split()
        if len(entries) == 2:
            seeds.add(entries[0])

    if len(seeds) < target_count:
        missing_count = target_count - len(seeds)
        print(f"File {file_name} is missing {missing_count} entries")

        missing_seeds = []
        for i in range(1, target_count+1):
            if str(i) not in seeds:
                missing_seeds.append(i)

            if len(missing_seeds) == missing_count:
                break

        print(f"\tmissing seeds {missing_seeds}")


def main():
    parser = argparse.ArgumentParser()

    parser.add_argument("--target_count", default=5, type=int,
                        help="minimal experiments necessary")

    parser.add_argument("--results_dir", default="exp_results", type=str,
                        help="directory path which contains the results")

    args = parser.parse_args()

    for model in models:
        # layers
        num_layers = 24
        if "base" in model:
            num_layers = 12

        for task, metrics in tasks.items():

            if "large" in model and task in ["QQP", "MNLI", "MNLI-MM", "QNLI"]:
                continue

            print(model, task)

            dir_path = "{0}/{1}/{2}".format(args.results_dir, model, task)

            if not os.path.exists(dir_path):
                print(f"Task {task} is missing for model {model}")
                continue

            for metric in metrics:
                # base
                base_file = dir_path + "/base-{}.txt".format(metric)

                check_results(base_file, args.target_count)

                # none
                none_file = dir_path + "/no_layer-{}.txt".format(metric)

                check_results(none_file, args.target_count)

                log_file_prefix=''
                for i in reversed(range(int(num_layers/2), num_layers)):
                    log_file_prefix += str(i)
                    layer_file = f"{dir_path}/{log_file_prefix}-{metric}.txt"
                    check_results(layer_file, args.target_count)
                    log_file_prefix += '_'


if __name__ == "__main__":
    main()
