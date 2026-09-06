# SD_CPP_oversimplified

> **Almost all credit for this project belongs to
> [stable-diffusion.cpp](https://github.com/leejet/stable-diffusion.cpp)
> by [leejet](https://github.com/leejet) and its contributors.** This
> repository is just a Docker wrapper around their work — it does not
> reimplement or improve on the inference engine itself. Please star,
> credit, and support the upstream project.

A GPU-accelerated Stable Diffusion inference server built on
[stable-diffusion.cpp](https://github.com/leejet/stable-diffusion.cpp),
deployed as containerized services. This repository contains the C++
server (built and run inside Docker).

## Repository layout

| Path | Description |
| --- | --- |
| `sd_server_cpp/` | The C++ server. Built from `stable-diffusion.cpp` inside Docker; contains the `Dockerfile`, the `models/` tree, and `servers/*.bash` launch scripts. |
| `sd_server_cpp/servers/` | One launch script per model/backend. Each is a thin wrapper around `/src/sd-server` with the correct flags wired up. |
| `sd_server_cpp/models/` | Downloaded model weights (GGUF `.gguf` and safetensors), VAEs, LoRAs, and vision mmprojs. |
| `docker-compose.yaml` | Compose file that builds and runs the server stack. |

## Supported models / backends

Each script in `sd_server_cpp/servers/` maps to one model. **These are
sample/experimental launch scripts, not production-optimized builds.**
They load whole models into memory, so they can easily OOM on smaller
GPUs. Adjust `--steps`, resolution, or `--cfg-scale` for constrained
hardware, and monitor VRAM with `nvidia-smi` before relying on any
script.

| Script | Model | Backend |
| --- | --- | --- |
| `flux2.bash` | flux-2-klein-9b | CUDA + FA |
| `krea2.bash` | Krea-2-Turbo | CUDA |
| `z-image.bash` | z-image-turbo | CUDA + FA |
| `qwen_image_edit.bash` | qwen-image-edit | CUDA + FA (text/image editing) |
| `hidream.bash` / `run_hidream.bash` | hidream_o1_image | CUDA |
| `pid.bash` | pid_flux2 (1024→4096 upsampling) | CUDA + FA |

## Configuration

Settings come from a `.env` file (see `sample.env`). Variables:

| Variable | Purpose |
| --- | --- |
| `HF_TOKEN` | Hugging Face token used to download gated model weights. |
| `PORT` | Port the server listens on (default `8080`). |
| `CUDA_VERSION` | Base image tag for the Docker build (`<version>-devel-ubuntu22.04`). Must match a CUDA version your NVIDIA driver supports — check with `nvidia-smi`. |

## Prerequisites

- A machine (or Docker daemon) with **NVIDIA CUDA** support.
- Docker and docker-compose installed.
- A Hugging Face account + token for downloading gated models.
## Build & run

The server is intended to be built and run entirely inside Docker. The
`Dockerfile` clones `stable-diffusion.cpp`, configures it with
`SD_CUDA=ON` and the Tornado-based frontend enabled, then compiles both
`sd-server` and `sd-cli` as release binaries.

```bash
# 1. Configure: copy sample.env over .env and set your own values
cp sample.env .env
#    - HF_TOKEN:      your Hugging Face token for gated models
#    - PORT:          port to expose (default 8080)
#    - CUDA_VERSION:  base-image tag for the Docker build

# 2. Build and run
docker compose up --build
```

This exposes the server on `PORT` and mounts `sd_server_cpp/` into the
container's working directory (`/workplace`), where model weights and
launch scripts live.

> **Treat the scripts as templates, not final builds.** The scripts in
> `sd_server_cpp/servers/` are samples that reference a fixed set of model
> weights and flags. To run your own models, treat them as a starting
> template: download your preferred model into `sd_server_cpp/models/`,
> point the relevant `*.bash` script at it, and adjust flags (steps,
> resolution, `--cfg-scale`) to fit your GPU's VRAM. Always check
> [stable-diffusion.cpp](https://github.com/leejet/stable-diffusion.cpp)
> documentation for the exact flags for your backend and hardware.

## Accessing the running container

First, find the container's name or ID:

```bash
docker ps
```

**Option A — open an interactive shell** (good for exploring, running
multiple commands, or debugging):

```bash
docker exec -it <container_name> bash
```

Once inside, you're at a normal bash prompt inside the container and
can run scripts directly, e.g.:

```bash
bash /workplace/servers/flux2.bash
```

**Option B — run a single command directly from the host** (no need to
enter the container first):

```bash
docker exec -it <container_name> bash /workplace/servers/flux2.bash
```

This runs the script and streams its output back to your host
terminal, without leaving you inside the container afterward. Useful
for quick one-off runs or scripting/automation.

Or run a one-off generation with the CLI (handy for quick checks),
from inside the container:

```bash
/src/sd-cli -m <path/to/base_model.gguf> -p "a prompt"
```

Once the server is running, its GUI is served over HTTP and can be
opened in a browser at `http://localhost:PORT` (replace `PORT` with
the value from your `.env`).

## Model files and paths

The launch scripts reference models under `/workplace/models/...`
(inside the container, `/workplace` is `sd_server_cpp/`). So model
weights belong in `sd_server_cpp/models/`, using the same sub-folders
the scripts expect:

```
sd_server_cpp/models/
├── base_models/       # the core diffusion models (.gguf / .safetensors)
├── encoders/          # LLM / vision encoder weights (.gguf / .safetensors)
├── mmproj/             # vision mmproj files (.gguf)
├── vae/               # VAE weights (.safetensors)
└── upscale_loras/      # upscaling LoRA weights
```

Since `*/models/*` is git-ignored, these folders do **not** exist in
the cloned repository. To run any script:

1. Create the folders above and download your preferred model weights
   into them (respecting the sub-folder each script uses).
2. Edit the corresponding `sd_server_cpp/servers/*.bash` script to
   point at your downloaded files, adjusting the model paths as
   needed.
3. Adjust the flags (`--steps`, resolution, `--cfg-scale`, etc.) to
   match your GPU's VRAM. See the
   [stable-diffusion.cpp](https://github.com/leejet/stable-diffusion.cpp)
   documentation for the exact flag list for your backend.
## Development notes

- Model files are git-ignored (`*/models/*`) to keep the repo light;
  download them separately into `sd_server_cpp/models/`.
## Credits & License

All the actual inference work here is done by
[stable-diffusion.cpp](https://github.com/leejet/stable-diffusion.cpp)
by [leejet](https://github.com/leejet) and its contributors. This
repository is nothing more than a thin Docker wrapper around it — the
Dockerfile, launch scripts, and config plumbing are the only things
original to this repo.

**stable-diffusion.cpp is MIT licensed.** This wrapper repo doesn't
change or override that — you're bound by its license and terms, not
just this repo's.

If you use this project, please:

- Respect the [stable-diffusion.cpp license and
  documentation](https://github.com/leejet/stable-diffusion.cpp) for
  anything related to the inference engine itself.
- Check the license and usage terms of **each specific model** you
  download and run (Flux, Krea, Z-Image, Qwen-Image-Edit, HiDream, PiD,
  etc.) — these are separate from stable-diffusion.cpp's license and
  vary by model author. Some are permissive, some have usage
  restrictions (commercial use, redistribution, generated-content
  terms, etc.).
- Direct bug reports or feature requests about the inference engine
  itself upstream to stable-diffusion.cpp, not this repo — this repo
  only wraps it in Docker.
