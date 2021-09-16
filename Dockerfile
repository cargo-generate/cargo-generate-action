FROM rust:latest as builder
RUN cargo install cargo-generate

FROM debian:stable-slim
RUN apt-get update \
    && apt-get install -y ca-certificates curl openssl libssl1.1 libcurl4-openssl-dev

COPY --from=builder /usr/local/cargo/bin/cargo-generate /usr/bin
ENTRYPOINT ["/entrypoint.sh"]
COPY entrypoint.sh /entrypoint.sh
