# Use an official base image that includes build essentials
FROM ubuntu:latest

# Set environment variables to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install GCC, GAS, and MinGW-w64 for cross-compilation
RUN apt-get update && \
    apt-get install -y gcc binutils vim-common bsdmainutils \
                       mingw-w64 gcc-mingw-w64 g++-mingw-w64 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace

# Command to run when the container starts (optional)
CMD ["/bin/bash"]
