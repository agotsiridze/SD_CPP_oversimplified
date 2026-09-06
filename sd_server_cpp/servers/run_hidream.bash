# /src/sd-server \
#   --model /workplace/models/base_models/HiDream-O1-Image-Dev-Q8_0.gguf \
#   --listen-ip 0.0.0.0 \
#   --listen-port 8080 \
#   --backend cuda \
#   --eager-load


/src/sd-server \
  --model /workplace/models/base_models/hidream_o1_image_bf16.safetensors \
  --llm /workplace/models/encoders/gemma4_e4b_it_fp8_scaled.safetensors \
  --listen-ip 0.0.0.0 \
  --listen-port 8080 \
  --backend cuda \
  --eager-load
