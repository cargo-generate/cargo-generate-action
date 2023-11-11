FROM rust:1.73.0-alpine3.18

ENV CARGO_GEN_VERSION="0.18.5"

# downloads from: https://github.com/cargo-generate/cargo-generate/releases/download/v0.18.4/cargo-generate-v0.18.4-x86_64-unknown-linux-musl.tar.gz
RUN set -eux; \
    apk update; \
    apk add bash curl git tar; \
    curl --silent -L https://github.com/cargo-generate/cargo-generate/releases/download/v$CARGO_GEN_VERSION/cargo-generate-v$CARGO_GEN_VERSION-x86_64-unknown-linux-musl.tar.gz | tar xzv -C /usr/bin/;

# Ensure rustup is up to date.
RUN bash -c "sh <(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs) -y"

# in order to avoid permission issues
# match here the GH runner UID and GID, so that generated files
# so all generated files are accessible from the pipeline run without an ugly
# ` - run: sudo chown -R runner:docker .` step
ARG UID=1001
ARG GID=121
ARG USERNAME=runner
ARG GROUPNAME=docker
RUN addgroup -g $GID $GROUPNAME
RUN adduser -D -H -u $UID -s /bin/bash $USERNAME $GROUPNAME
USER $USERNAME

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
