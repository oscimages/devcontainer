FROM ubuntu:22.04

# Setup apt packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    git \
    make \
    nmap \
    dnsutils \
    strace \
 && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

# Create vscode user
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000
RUN cut -d: -f 3 /etc/group | grep -w $USER_GID || groupadd --gid $USER_GID $USERNAME
#RUN useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME