#!/bin/bash
REAL_SCRIPT_PATH=$(realpath "$0" 2>/dev/null || readlink -f "$0")
SCRIPT_DIR=$(dirname "$REAL_SCRIPT_PATH")

ssh -i "$SCRIPT_DIR/qemukey" root@localhost -p 2222