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

## 2. Overview

![Compose flow](/assets/images/triton_tensorrtllm_compose.jpg)

- There are 2 components:
  - `converter` with public image: `ghcr.io/janhq/triton_tensorrt_llm:engine_build_89_90_5955b8afbad2ddcc3156202b16c567e94c52248f`
  - `triton` with public image:`ghcr.io/janhq/triton_tensorrt_llm:engine_build_89_90_41fe3a6a9daa12c64403e084298c6169b07d489d`

## 2. Steps

- Run command

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
