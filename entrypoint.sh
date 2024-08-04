#!/bin/bash
set -e

export PATH=$PATH:/usr/local/cargo/bin

if [ -z "$USER" ]; then
    export USER="runner"
fi

# Separate arguments before passing them
args=$(echo "$@" | xargs)

/usr/bin/cargo-generate generate --silent $args
