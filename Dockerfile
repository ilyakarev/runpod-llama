FROM ghcr.io/ggml-org/llama.cpp:server-cuda13

ENV MODEL_DIR=/models
RUN mkdir -p ${MODEL_DIR}

ENV HF_REPO_ID=Jackrong/Qwopus3.6-27B-v2-MTP-GGUF
ENV HF_FILENAME=Qwopus3.6-27B-v2-MTP-Q8_0.gguf

# Скачиваем модель (публичная)
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl \
  && rm -rf /var/lib/apt/lists/*

RUN curl -L --fail --retry 5 --retry-delay 2 \
  -o "${MODEL_DIR}/${HF_FILENAME}" \
  "https://huggingface.co/${HF_REPO_ID}/resolve/main/${HF_FILENAME}"

# Порт (как в примере)
EXPOSE 8080

# Обратите внимание: это аргументы, которые потребляет entrypoint внутри server-cuda image
# LLAMA_ARGS вы можете переопределять через Template/Pod env, но проще сразу задать CMD.
CMD ["-m","/models/Qwopus3.6-27B-v2-MTP-Q8_0.gguf",
     "--port","8080","--host","0.0.0.0",
     "-ngl","999",
     "--cache-type-k","q8_0","--cache-type-v","q8_0",
     "--spec-type","mtp",
     "-c","131072",
     "--temp","1.0"]
