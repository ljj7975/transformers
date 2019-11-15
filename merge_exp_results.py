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

def copy_results(source_file, target_file):
    if not os.path.exists(source_file):
        return

    if not os.path.exists(target_file):
        Path(target_file).touch()

    print(source_file)
    print(target_file)

    # read in source, create a map
    source_map = {}
    file = open(source_file, "r")
    lines = file.read().splitlines()
    for line in lines:
        entries = line.split()
        if len(entries) == 2:
            source_map[entries[0]] = entries[1]

    # read in target, create a map
    target_map = {}
    file = open(target_file, "r")
    lines = file.read().splitlines()
    for line in lines:
        entries = line.split()
        if len(entries) == 2:
            target_map[entries[0]] = entries[1]
        else:
            print("Entry of incorrect format exist in ", target_file)

    # check if target is missing any item from source
    file = open(target_file, "a+")
    missing_count = 0
    for source_key, source_value in source_map.items():
        if source_key not in target_map:
            missing_count += 1

            text = f"{source_key}\t{source_value}\n"
            file.write(text)

    print("\t", source_file, missing_count)
    


def main():
    parser = argparse.ArgumentParser()

    parser.add_argument("--source_dir", default="logs", type=str,
                        help="directory path which contains the source results")

    parser.add_argument("--target_dir", default="exp_results", type=str,
                        help="directory path which the results will be updated")
    
    args = parser.parse_args()

    for model in models:
        for task, metrics in tasks.items():
            print(model, task)

            source_dir_path = "{0}/{1}/{2}".format(args.source_dir, model, task)

            if not os.path.exists(source_dir_path):
                continue

            target_dir_path = "{0}/{1}/{2}".format(args.target_dir, model, task)

            for metric in metrics:
                # base
                source_file = source_dir_path + "/base-{}.txt".format(metric)
                target_file = target_dir_path + "/base-{}.txt".format(metric)

                copy_results(source_file, target_file)

                # none
                source_file = source_dir_path + "/no_layer-{}.txt".format(metric)
                target_file = target_dir_path + "/no_layer-{}.txt".format(metric)

                copy_results(source_file, target_file)

                # layers

                num_layers = 24
                if "base" in model:
                    num_layers = 12

                log_file_prefix=''
                for i in reversed(range(int(num_layers/2), num_layers)):
                    log_file_prefix += str(i)
                    source_file = f"{source_dir_path}/{log_file_prefix}-{metric}.txt"
                    target_file = f"{target_dir_path}/{log_file_prefix}-{metric}.txt"

                    copy_results(source_file, target_file)
                    log_file_prefix += '_'


if __name__ == "__main__":
    main()
