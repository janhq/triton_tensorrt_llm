# Triton TensorRT_LLM deployment

## 0. Prerequisites

- Docker engine - [Installation](https://docs.docker.com/engine/install/)
- Docker compose - [Installation](https://docs.docker.com/compose/install/)
- NVIDIA Container Toolkit - [Installation](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)
- NVIDIA GPU (The converter and triton both require GPU acess)

## 1. Tested environments

- OS with GPU:
  - [x] Linux with 4090
  - [ ] Linux with 3090
- Model:
  - [jan-hq/stealth-v1.2](https://huggingface.co/jan-hq/stealth-v1.2)

## 2. Steps

- Run the command for automated converter and triton setup
  ![Compose flow](/assets/images/triton_tensorrtllm_compose.jpg)

```bash
docker compose up -d
```

- Test API

```
curl --location 'http://localhost:8000/v2/models/tensorrt_llm_bls/generate_stream' \
--header 'Accept: text/event-stream' \
--header 'Content-Type: application/json' \
--data '{
    "text_input": "What is machine learning?",
    "parameters": {
        "stream": false,
        "temperature": 0,
        "max_tokens": 20
    }
}'

curl --location 'http://localhost:8000/v2/models/tensorrt_llm_bls/generate' \
--header 'Content-Type: application/json' \
--data '{
    "text_input": "What is machine learning?",
    "parameters": {
        "stream": true,
        "temperature": 0,
        "max_tokens": 20
    }
}'
```
