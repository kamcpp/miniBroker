#!/bin/bash

# Script to generate Dart gRPC client code from proto files

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}Generating Dart gRPC client code...${NC}"

# Check if protoc is installed
if ! command -v protoc &> /dev/null; then
    echo -e "${RED}Error: protoc is not installed. Please install Protocol Buffers compiler.${NC}"
    echo -e "${YELLOW}On macOS: brew install protobuf${NC}"
    echo -e "${YELLOW}On Ubuntu: sudo apt install protobuf-compiler${NC}"
    exit 1
fi

# Check if protoc-gen-dart is installed
if ! command -v protoc-gen-dart &> /dev/null; then
    echo -e "${YELLOW}Installing protoc-gen-dart plugin...${NC}"
    dart pub global activate protoc_plugin 21.1.2
    export PATH="$PATH":"$HOME/.pub-cache/bin"
fi

# Ensure we're using the correct version compatible with protobuf 3.x
export PATH="$HOME/.pub-cache/bin:$PATH"

# Create output directory
OUTPUT_DIR="lib/generated"
mkdir -p "$OUTPUT_DIR"

# Proto source directory
PROTO_DIR="proto"

echo -e "${GREEN}Compiling proto files...${NC}"

# Generate Dart files from proto files
# Using the proto directory as the base path to handle imports correctly
protoc \
    --proto_path="$PROTO_DIR/qomet/agora/daemons/api/grpc" \
    --dart_out=grpc:"$OUTPUT_DIR" \
    "$PROTO_DIR/qomet/agora/daemons/api/grpc/"*.proto \
    "$PROTO_DIR/qomet/agora/daemons/api/grpc/prtagent/v1/"*.proto

echo -e "${GREEN}✅ Proto compilation completed!${NC}"
echo -e "${YELLOW}Generated files are in: $OUTPUT_DIR${NC}"

# List generated files
echo -e "${GREEN}Generated files:${NC}"
find "$OUTPUT_DIR" -name "*.dart" | sort