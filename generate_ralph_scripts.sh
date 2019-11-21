#!/bin/bash
account=$1
#kshook or lilimou

if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters"
    exit
fi

echo "copying scripts"

cp -rf scripts "scripts_$account"
cd "scripts_$account"

if [[ $account == "lilimou" ]]
then
    echo "scripts_$account"
    find ./ -type f -exec sed -i -e "s/jimmylin/lilimou/g" {} \;
elif [[ $account == "kshook" ]]
then
    echo "scripts_$account"
    find ./ -type f -exec sed -i -e "s/jimmylin/kshook/g" {} \;
else
    echo "Invalid account name: "$account
    echo "keeping the account as jimmylin"
    exit 1
fi

cd ..
