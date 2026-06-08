#!/usr/bin/env bash
set -euo pipefail

: "${PORT:=8080}"
: "${MODEL_DIR:=/models}"
: "${LLAMA_ARGS:=}"

if [[ -z "${MODEL_PATH:-}" ]]; then
  : "${HF_FILENAME:?HF_FILENAME must be set (baked in image)}"
  MODEL_PATH="${MODEL_DIR}/${HF_FILENAME}"
fi

echo "Model: ${MODEL_PATH}"
echo "Port: ${PORT}"
echo "LLAMA_ARGS: ${LLAMA_ARGS}"

exec llama-server \
  --model "${MODEL_PATH}" \
  --port "${PORT}" \
  ${LLAMA_ARGS}
