FROM ubuntu:22.04

# Setup apt packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    sudo \
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
ENV USERNAME=$USERNAME
ENV USER_UID=$USER_UID
ENV USER_GID=$USER_GID

# Add sudo support for non-root user
RUN echo "%sudo ALL=(ALL:ALL) NOPASSWD:ALL"  > /etc/sudoers.d/nopasswd

RUN cut -d: -f 3 /etc/group | grep -w $USER_GID || groupadd --gid $USER_GID $USERNAME
RUN useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -G sudo -m $USERNAME

# Install Node LTS
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    curl nodejs npm \
 && apt-get -y autoremove && rm -rf /var/lib/apt/lists/* \
 && npm install n -g \
 && n lts \
 && apt-get -y purge nodejs npm
RUN npm install npm -g
