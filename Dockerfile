FROM ubuntu:22.04

# Setup apt packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    git \
    make \
    nmap \
    dnsutils \
    strace \
 && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*
