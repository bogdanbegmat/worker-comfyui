# Step 1: Use a base image with Python 3.12, which matches your venv.
FROM runpod/pytorch:2.3.0-py3.12-cuda12.1.1-devel-ubuntu22.04

# Step 2: Install basic tools and copy the worker's own source code.
# This does NOT install ComfyUI or Python requirements.
WORKDIR /
RUN apt-get update && apt-get install -y --no-install-recommends git wget && rm -rf /var/lib/apt/lists/*
COPY ./src /src
WORKDIR /src

# Step 3: Define the command to run when the worker starts.
# This command first activates your virtual environment from the network volume,
# and then starts the worker script.
CMD ["/bin/bash", "-c", "source /workspace/venv312/bin/activate && python -u worker.py"]
