#!/bin/bash
set -e

export PATH=$PATH:/usr/local/cargo/bin

if [ -z "$USER" ]; then
    export USER="runner"
fi

/usr/bin/cargo-generate generate --silent $*
