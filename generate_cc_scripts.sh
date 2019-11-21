#!/bin/bash

mkdir cc_scripts

echo "copying scripts"

cp -rf scripts "cc_scripts/scripts_jimmy"

cp -rf scripts "cc_scripts/scripts_kshook"
cd "cc_scripts/scripts_kshook"
find ./ -type f -exec sed -i -e "s/jimmylin/kshook/g" {} \;
cd ../..

cp -rf scripts "cc_scripts/scripts_lilimou"
cd "cc_scripts/scripts_lilimou"
find ./ -type f -exec sed -i -e "s/jimmylin/lilimou/g" {} \;
cd ../..
