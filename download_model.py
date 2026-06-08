from huggingface_hub import hf_hub_download

repo = "Jackrong/Qwopus3.6-27B-v2-MTP-GGUF"
file = "Qwopus3.6-27B-v2-MTP-Q8_0.gguf"

path = hf_hub_download(repo_id=repo, filename=file, local_dir="/models")
print("Downloaded to:", path)
