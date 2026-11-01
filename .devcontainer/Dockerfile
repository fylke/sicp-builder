FROM docker.io/library/debian:trixie-slim

# Racket (with the `sicp` language) and MIT Scheme, the book's own dialect.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        git \
        libcairo2 \
        libfontconfig1 \
        libjpeg62-turbo \
        libpango-1.0-0 \
        libpangocairo-1.0-0 \
        fonts-dejavu-core \
        mit-scheme \
        racket \
        rlwrap \
        sudo \
    && rm -rf /var/lib/apt/lists/*

# The `sicp` package provides `#lang sicp`: cons-stream, the picture language
# (`sicp/pict`, which needs the Cairo/Pango libraries above) and the other extras
# the book assumes. It is installed system-wide so every user gets it.
RUN raco pkg install --auto --no-docs --scope installation sicp

ARG USERNAME=vscode
RUN useradd --create-home --shell /bin/bash "$USERNAME" \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME
USER $USERNAME
WORKDIR /workspaces/sicp-builder
