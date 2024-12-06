#!/bin/bash

# Set the default value for the stage argument
stage="prove"

# Check the number of arguments
if [ $# -lt 2 ] || [ $# -gt 3 ]; then
    echo "Usage: $0 <s3_path> <cpu|cuda> [execute|prove]"
    exit 1
fi

# If the third argument is provided, override the default value
if [ $# -eq 3 ]; then
    stage="$3"
fi

s3_path=$1
kind=$2

# Download files from S3
aws s3 cp s3://sp1-testing-suite/$s3_path/program.bin /tmp/program.bin
aws s3 cp s3://sp1-testing-suite/$s3_path/stdin.bin /tmp/stdin.bin

# Set environment variables
export RUSTFLAGS="-Copt-level=3 -Ctarget-cpu=native -Cdebuginfo=2"
export RUST_BACKTRACE=1
export RUST_LOG=debug
export SP1_DEBUG=1

# Run moongate-perf
cargo run -p sp1-perf -- --program /tmp/program.bin --stdin /tmp/stdin.bin --mode $kind --stage $stage