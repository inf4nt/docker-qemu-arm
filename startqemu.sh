#!/bin/bash

REAL_SCRIPT_PATH=$(realpath "$0" 2>/dev/null || readlink -f "$0")
SCRIPT_DIR=$(dirname "$REAL_SCRIPT_PATH")
cd "$SCRIPT_DIR" || exit 1

export PREFIX=/data/data/com.termux/files/usr

if [ -f ../config.env ]; then
    . ../config.env
fi
QEMU_RAM=${QEMU_RAM:-2048}
QEMU_CPUS=${QEMU_CPUS:-6}

qemu-system-aarch64 -machine virt -m "$QEMU_RAM" -smp cpus="$QEMU_CPUS" -cpu cortex-a72 \
  -drive if=pflash,format=raw,read-only=on,file=$PREFIX/share/qemu/edk2-aarch64-code.fd \
  -netdev user,id=n1,hostfwd=tcp::2222-:22,net=192.168.50.0/24,hostfwd=tcp::9000-:9000 -device virtio-net,netdev=n1 \
  -nographic alpine.img