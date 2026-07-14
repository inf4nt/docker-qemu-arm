#!/bin/bash

REAL_SCRIPT_PATH=$(realpath "$0" 2>/dev/null || readlink -f "$0")
SCRIPT_DIR=$(dirname "$REAL_SCRIPT_PATH")
cd "$SCRIPT_DIR" || exit 1

pkg install -y expect qemu-utils qemu-common qemu-system-aarch64-headless openssh

mkdir -p alpine
cd alpine

. ../config.env
cp ../answerfile .
cp ../ssh2qemu.sh .
cp ../startqemu.sh .

chmod +x ./ssh2qemu.sh
chmod +x ./startqemu.sh

expect -f ../installqemu.expect
