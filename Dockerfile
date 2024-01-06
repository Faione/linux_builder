FROM docker.io/library/debian:bookworm-slim

ARG ARCH=x86

ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=Asia/Shanghai

# basic env
COPY apt/sources.list /etc/apt/sources.list

RUN apt-get update && apt-get -y install \
  build-essential bc kmod cpio flex \
  libncurses5-dev libelf-dev libssl-dev libzstd-dev \
  dwarves bison ca-certificates curl git pkg-config rsync gdb

# clang 17 env
COPY apt/sources.list.with.llvm /etc/apt/sources.list

COPY apt/apt.llvm.org.asc /etc/apt/trusted.gpg.d/apt.llvm.org.asc

RUN apt-get update && apt-get -y install clang-17 clangd lld

ENV PATH=/usr/lib/llvm-17/bin:$PATH

# rust env
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
