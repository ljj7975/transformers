# bert
mkdir bert-base-uncased
mkdir bert-large-uncased


if [ ! -f bert-base-uncased/config.json ]; then
    wget https://s3.amazonaws.com/models.huggingface.co/bert/bert-base-uncased-config.json -O bert-base-uncased/config.json
fi
if [ ! -f bert-large-uncased/config.json ]; then
    wget https://s3.amazonaws.com/models.huggingface.co/bert/bert-large-uncased-config.json -O bert-large-uncased/config.json
fi

if [ ! -f bert-base-uncased/pytorch_model.bin ]; then
    nohup https://s3.amazonaws.com/models.huggingface.co/bert/bert-base-uncased-pytorch_model.bin -O bert-base-uncased/pytorch_model.bin > bert-base-uncased-pytorch_model.out &
fi
if [ ! -f bert-large-uncased/pytorch_model.bin ]; then
    nohup https://s3.amazonaws.com/models.huggingface.co/bert/bert-large-uncased-pytorch_model.bin -O bert-large-uncased/pytorch_model.bin > bert-large-uncased-pytorch_model.out &
fi

if [ ! -f bert-base-uncased/vocab.txt ]; then
    wget https://s3.amazonaws.com/models.huggingface.co/bert/bert-base-uncased-vocab.txt -O bert-base-uncased/vocab.txt
fi
if [ ! -f bert-large-uncased/vocab.txt ]; then
    wget https://s3.amazonaws.com/models.huggingface.co/bert/bert-large-uncased-vocab.txt -O bert-large-uncased/vocab.txt
fi


# roberta

mkdir roberta-base
mkdir roberta-large

if [ ! -f roberta-base/config.json ]; then
    wget https://s3.amazonaws.com/models.huggingface.co/bert/roberta-base-config.json -O roberta-base/config.json
fi
if [ ! -f roberta-large/config.json ]; then
    wget https://s3.amazonaws.com/models.huggingface.co/bert/roberta-large-config.json -O roberta-large/config.json
fi

if [ ! -f roberta-base/pytorch_model.bin ]; then
    nohup wget https://s3.amazonaws.com/models.huggingface.co/bert/roberta-base-pytorch_model.bin -O roberta-base/pytorch_model.bin > roberta-base-pytorch_model.out &
fi
if [ ! -f roberta-large/pytorch_model.bin ]; then
    nohup wget https://s3.amazonaws.com/models.huggingface.co/bert/roberta-large-pytorch_model.bin -O roberta-large/pytorch_model.bin > roberta-large-pytorch_model.out &
fi


if [ ! -f roberta-base/vocab.json ]; then
    wget https://s3.amazonaws.com/models.huggingface.co/bert/roberta-base-vocab.json -O roberta-base/vocab.json
fi
if [ ! -f roberta-large/vocab.json ]; then
    wget https://s3.amazonaws.com/models.huggingface.co/bert/roberta-large-vocab.json -O roberta-large/vocab.json
fi


if [ ! -f roberta-base/merges.txt ]; then
    wget https://s3.amazonaws.com/models.huggingface.co/bert/roberta-base-merges.txt -O roberta-base/merges.txt
fi
if [ ! -f roberta-large/merges.txt ]; then
    wget https://s3.amazonaws.com/models.huggingface.co/bert/roberta-large-merges.txt -O roberta-large/merges.txt
fi

# xlnet


mkdir xlnet-base-cased
mkdir xlnet-large-cased

if [ ! -f xlnet-base-cased/config.json ]; then
    wget https://s3.amazonaws.com/models.huggingface.co/bert/xlnet-base-cased-config.json -O xlnet-base-cased/config.json
fi
if [ ! -f xlnet-large-cased/config.json ]; then
    wget https://s3.amazonaws.com/models.huggingface.co/bert/xlnet-large-cased-config.json -O xlnet-large-cased/config.json
fi


if [ ! -f xlnet-base-cased/pytorch_model.bin  ]; then
    nohup wget https://s3.amazonaws.com/models.huggingface.co/bert/xlnet-base-cased-pytorch_model.bin -O xlnet-base-cased/pytorch_model.bin > xlnet-base-cased-pytorch_model.out &
fi
if [ ! -f xlnet-large-cased/pytorch_model.bin  ]; then
    nohup wget https://s3.amazonaws.com/models.huggingface.co/bert/xlnet-large-cased-pytorch_model.bin -O xlnet-large-cased/pytorch_model.bin > xlnet-large-cased-pytorch_model.out &
fi

if [ ! -f xlnet-base-cased/spiece.model ]; then
    wget https://s3.amazonaws.com/models.huggingface.co/bert/xlnet-base-cased-spiece.model -O xlnet-base-cased/spiece.model
fi
if [ ! -f xlnet-large-cased/spiece.model ]; then
    wget https://s3.amazonaws.com/models.huggingface.co/bert/xlnet-large-cased-spiece.model -O xlnet-large-cased/spiece.model
fi

