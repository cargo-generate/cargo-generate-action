#!/bin/bash
set -e

export PATH=$PATH:/usr/local/cargo/bin

if [ -z "$USER" ]; then
    export USER="runner"
fi

printf '%s\n' "generate --silent $*" | xargs /usr/bin/cargo-generate
