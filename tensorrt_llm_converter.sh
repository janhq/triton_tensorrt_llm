pip install -U "huggingface_hub[cli]" hf_transfer
huggingface-cli login --token $HUGGINGFACE_TOKEN --add-to-git-credential

mkdir -p /engine && mkdir -p /model && mkdir -p /checkpoint

HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download --repo-type model --local-dir /model $MODEL_ID

cd examples/llama

python3 convert_checkpoint.py --model_dir /model \
    --output_dir /checkpoint \
    --dtype float16

trtllm-build --checkpoint_dir /checkpoint \
    --output_dir /engine \
    --gemm_plugin float16

cp /model/tokenizer.json /tokenizer
cp /model/tokenizer.model /tokenizer
cp /model/tokenizer_config.json /tokenizer
