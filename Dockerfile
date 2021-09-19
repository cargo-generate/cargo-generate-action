FROM rust:latest as builder
RUN cargo install cargo-generate

FROM debian:stable-slim

RUN apt-get update \
    && apt-get install -y ca-certificates curl openssl libssl1.1 libcurl4-openssl-dev

COPY --from=builder /usr/local/cargo/bin/cargo-generate /usr/bin

# in order to avoid permission issues
# match here the GH runner UID and GID, so that generated files
# so all generated files are accessible from the pipeline run without an ugly
# ` - run: sudo chown -R runner:docker .` step
ARG UID=1001
ARG GID=121
ARG USERNAME=runner
ARG GROUPNAME=docker
RUN groupadd -g $GID -o $GROUPNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $USERNAME
USER $USERNAME

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
