#!/bin/bash
account=$1

cp -rf scripts ralph_scripts
cd ralph_scripts

find ./ -type f -exec sed -i -e 's/source ~\/ENV\/bin\/activate//g' {} \;

find ./ -type f -exec sed -i -e 's/deactivate//g' {} \;

find ./ -type f -exec sed -i -e 's/jimmylin/$account/g' {} \;

cd ..