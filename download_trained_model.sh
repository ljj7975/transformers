mkdir xlnet-base-cased
mkdir xlnet-large-cased

wget https://s3.amazonaws.com/models.huggingface.co/bert/xlnet-base-cased-config.json -O xlnet-base-cased/config.json
wget https://s3.amazonaws.com/models.huggingface.co/bert/xlnet-large-cased-config.json -O xlnet-large-cased/config.json


nohup wget https://s3.amazonaws.com/models.huggingface.co/bert/xlnet-base-cased-pytorch_model.bin -O xlnet-base-cased/pytorch_model.bin > xlnet-base-cased-pytorch_model.out &
nohup wget https://s3.amazonaws.com/models.huggingface.co/bert/xlnet-large-cased-pytorch_model.bin -O xlnet-large-cased/pytorch_model.bin > xlnet-large-cased-pytorch_model.out &

wget https://s3.amazonaws.com/models.huggingface.co/bert/xlnet-base-cased-spiece.model -O xlnet-base-cased/spiece.model
wget https://s3.amazonaws.com/models.huggingface.co/bert/xlnet-large-cased-spiece.model -O xlnet-large-cased/spiece.model

