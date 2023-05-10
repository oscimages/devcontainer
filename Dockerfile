FROM ubuntu:22.04

# Setup minimal apt packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates \
    sudo \
    git \
    curl \
    unzip \
    zsh \
 && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

# Setup apt packages
# RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
#     make \
#     nmap \
#     dnsutils \
#     strace \
#  && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

COPY files/.bashrc /etc/skel/.bashrc
COPY files/asdf-install /usr/local/bin
RUN chmod +x /usr/local/bin/asdf-install

# Create vscode user
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000
ENV USERNAME=$USERNAME
ENV USER_UID=$USER_UID
ENV USER_GID=$USER_GID

# Add sudo support for non-root user
RUN echo "%sudo ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/nopasswd

RUN cut -d: -f 3 /etc/group | grep -w $USER_GID || groupadd --gid $USER_GID $USERNAME
RUN useradd -s /bin/zsh --uid $USER_UID --gid $USER_GID -G sudo -m $USERNAME
COPY --chown=${USERNAME}:${USERNAME} files/.tool-versions /home/${USERNAME}/.tool-versions

# Install asdf https://asdf-vm.com/guide/getting-started.html#_1-install-dependencies
USER $USERNAME
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3
WORKDIR /home/${USERNAME}
RUN bash -c ". /home/${USERNAME}/.asdf/asdf.sh && asdf-install"
WORKDIR /
