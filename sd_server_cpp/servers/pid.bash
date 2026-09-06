/src/sd-server \
  --backend cuda \
  --diffusion-model /workplace/models/base_models/pid_flux2_1024_to_4096_4step_bf16.safetensors \
  --vae /workplace/models/vae/flux2_ae.safetensors \
  --vae-format flux2 \
  --llm /workplace/models/encoders/gemma_2_2b_it_elm_bf16.safetensors \
  --fa \
  --listen-ip 0.0.0.0 \
  --listen-port 8080 \
  --eager-load
