FROM ghcr.io/ggml-org/llama.cpp@sha256:88f868dbe043ff170c35ca4906feda0ef648245eeb1b80dfa5bee71e3dac5f99

ENV MODEL_DIR=/models
RUN mkdir -p ${MODEL_DIR}

# Инструменты для скачивания с HF (модель публичная — токен не нужен)
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-pip ca-certificates \
  && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir -U huggingface_hub

# Запекаем модель в image
ENV HF_REPO_ID=Jackrong/Qwopus3.6-27B-v2-MTP-GGUF
ENV HF_FILENAME=Qwopus3.6-27B-v2-MTP-Q8_0.gguf

COPY download_model.py /download_model.py
RUN python3 /download_model.py

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV PORT=8080
ENV LLAMA_ARGS=""
ENV MODEL_PATH=""

EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]
