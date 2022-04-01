#!/bin/bash -ex

# Linux host operating system
uname -s | grep -q "Linux" && /bin/sh -c ' \
  eval "$(./scripts/makeops/system-detect/system-detect.sh)"; \
  env | grep ^SYSTEM_; \
  [ $SYSTEM_NAME = linux ] && [ $SYSTEM_CONTAINER = false ] \
'

# macOS host operating system
uname -s | grep -q "Darwin" && /bin/sh -c ' \
  eval "$(./scripts/makeops/system-detect/system-detect.sh)"; \
  env | grep ^SYSTEM_; \
  [ $SYSTEM_NAME = unix ] && [ $SYSTEM_DIST = macos ] && [ $SYSTEM_CONTAINER = false ] \
'

# ==============================================================================

# Debian image
docker run --interactive --tty --rm \
  --volume "$PWD":/project:ro \
  --workdir /project \
  debian:bullseye-20220316 \
    /bin/sh -c ' \
      eval "$(./scripts/makeops/system-detect/system-detect.sh)"; \
      env | grep ^SYSTEM_; \
      [ $SYSTEM_DIST = debian ] && [ $SYSTEM_VERSION = "11.2" ] && [ $SYSTEM_CONTAINER = true ] \
    '

# Ubuntu image
docker run --interactive --tty --rm \
  --volume "$PWD":/project:ro \
  --workdir /project \
  ubuntu:jammy-20220315 \
    /bin/sh -c ' \
      eval "$(./scripts/makeops/system-detect/system-detect.sh)"; \
      env | grep ^SYSTEM_; \
      [ $SYSTEM_DIST = ubuntu ] && [ $SYSTEM_VERSION = 22.04 ] && [ $SYSTEM_CONTAINER = true ] \
    '

# Kali image
docker run --interactive --tty --rm \
  --volume "$PWD":/project:ro \
  --workdir /project \
  kalilinux/kali-last-release \
    /bin/sh -c ' \
      eval "$(./scripts/makeops/system-detect/system-detect.sh)"; \
      env | grep ^SYSTEM_; \
      [ $SYSTEM_DIST = kali ] && [ $SYSTEM_VERSION = 2022.1 ] && [ $SYSTEM_CONTAINER = true ] \
    '

# --------------------------------------

# ReadHat image
docker run --interactive --tty --rm \
  --volume "$PWD":/project:ro \
  --workdir /project \
  redhat/ubi8-minimal:8.5-240 \
    /bin/sh -c ' \
      eval "$(./scripts/makeops/system-detect/system-detect.sh)"; \
      env | grep ^SYSTEM_; \
      [ $SYSTEM_DIST = redhat ] && [ $SYSTEM_VERSION = 8.5 ] && [ $SYSTEM_CONTAINER = true ] \
    '

# CentOS image
docker run --interactive --tty --rm \
  --volume "$PWD":/project:ro \
  --workdir /project \
  centos:7.9.2009 \
    /bin/sh -c ' \
      eval "$(./scripts/makeops/system-detect/system-detect.sh)"; \
      env | grep ^SYSTEM_; \
      [ $SYSTEM_DIST = centos ] && [ $SYSTEM_VERSION = 7.9.2009 ] && [ $SYSTEM_CONTAINER = true ] \
    '

# --------------------------------------

# Alpine image
docker run --interactive --tty --rm \
  --volume "$PWD":/project:ro \
  --workdir /project \
  alpine:20220316 \
    /bin/sh -c ' \
      eval "$(./scripts/makeops/system-detect/system-detect.sh)"; \
      env | grep ^SYSTEM_; \
      [ $SYSTEM_DIST = alpine ] && [ $SYSTEM_VERSION = 3.16.0 ] && [ $SYSTEM_CONTAINER = true ] \
    '

# Busybox image
docker run --interactive --tty --rm \
  --volume "$PWD":/project:ro \
  --workdir /project \
  busybox:1.34.1 \
    /bin/sh -c ' \
      eval "$(./scripts/makeops/system-detect/system-detect.sh)"; \
      env | grep ^SYSTEM_; \
      [ $SYSTEM_DIST = busybox ] && [ $SYSTEM_VERSION = 1.34.1 ] && [ $SYSTEM_CONTAINER = true ] \
    '

# ==============================================================================

# AWS Lambda (Python) cloud image
output=$(
  docker run --interactive --tty --rm \
    --volume "$PWD":/project:ro \
    --workdir /project \
    --entrypoint /project/scripts/makeops/system-detect/system-detect-docker-entrypoint.test.sh \
    amazon/aws-lambda-python:3.6.2022.03.23.17 \
      /bin/sh -c \
        ./scripts/makeops/system-detect/system-detect.sh
)
echo "$output" | grep -E "SYSTEM_DIST=amazon"
echo "$output" | grep -E "SYSTEM_VERSION=202203161534-al2018.03.835.0"
echo "$output" | grep -E "SYSTEM_CONTAINER=true"

# AWS Lambda (Java) cloud image
output=$(
  docker run --interactive --tty --rm \
    --volume "$PWD":/project:ro \
    --workdir /project \
    --entrypoint /project/scripts/makeops/system-detect/system-detect-docker-entrypoint.test.sh \
    amazon/aws-lambda-java:11.2022.03.23.17 \
      /bin/sh -c \
        ./scripts/makeops/system-detect/system-detect.sh
)
echo "$output" | grep -E "SYSTEM_DIST=amazon"
echo "$output" | grep -E "SYSTEM_VERSION=202203161534-2.0.771.0"
echo "$output" | grep -E "SYSTEM_CONTAINER=true"

# Amazon Corretto cloud image
output=$(
  docker run --interactive --tty --rm \
    --volume "$PWD":/project:ro \
    --workdir /project \
    --entrypoint /project/scripts/makeops/system-detect/system-detect-docker-entrypoint.test.sh \
    amazoncorretto:17 \
      /bin/sh -c \
        ./scripts/makeops/system-detect/system-detect.sh
)
echo "$output" | grep -E "SYSTEM_DIST=amazon"
echo "$output" | grep -E "SYSTEM_VERSION=2"
echo "$output" | grep -E "SYSTEM_CONTAINER=true"

# AWS Lambda (NodeJS) cloud image
output=$(
  docker run --interactive --tty --rm \
    --volume "$PWD":/project:ro \
    --workdir /project \
    --entrypoint /project/scripts/makeops/system-detect/system-detect-docker-entrypoint.test.sh \
    amazon/aws-lambda-nodejs:14.2022.03.23.16 \
      /bin/sh -c \
        ./scripts/makeops/system-detect/system-detect.sh
)
echo "$output" | grep -E "SYSTEM_DIST=amazon"
echo "$output" | grep -E "SYSTEM_VERSION=202203161534-2.0.771.0"
echo "$output" | grep -E "SYSTEM_CONTAINER=true"

# AWS Lambda (.NET) cloud image
output=$(
  docker run --interactive --tty --rm \
    --volume "$PWD":/project:ro \
    --workdir /project \
    --entrypoint /project/scripts/makeops/system-detect/system-detect-docker-entrypoint.test.sh \
    amazon/aws-lambda-dotnet:6.2022.03.23.17 \
      /bin/sh -c \
        ./scripts/makeops/system-detect/system-detect.sh
)
echo "$output" | grep -E "SYSTEM_DIST=amazon"
echo "$output" | grep -E "SYSTEM_VERSION=202203161534-2.0.771.0"
echo "$output" | grep -E "SYSTEM_CONTAINER=true"

# --------------------------------------

# Azure Functions (Python) cloud image
output=$(
  docker run --interactive --tty --rm \
    --volume "$PWD":/project:ro \
    --workdir /project \
    --entrypoint /project/scripts/makeops/system-detect/system-detect-docker-entrypoint.test.sh \
    mcr.microsoft.com/azure-functions/python:4-python3.9 \
      /bin/sh -c \
        ./scripts/makeops/system-detect/system-detect.sh
)
echo "$output" | grep -E "SYSTEM_DIST=debian"
echo "$output" | grep -E "SYSTEM_VERSION=11.2"
echo "$output" | grep -E "SYSTEM_CONTAINER=true"

# Azure Functions (Java) cloud image
output=$(
  docker run --interactive --tty --rm \
    --volume "$PWD":/project:ro \
    --workdir /project \
    --entrypoint /project/scripts/makeops/system-detect/system-detect-docker-entrypoint.test.sh \
    mcr.microsoft.com/azure-functions/java:4-java11 \
      /bin/sh -c \
        ./scripts/makeops/system-detect/system-detect.sh
)
echo "$output" | grep -E "SYSTEM_DIST=debian"
echo "$output" | grep -E "SYSTEM_VERSION=11.1"
echo "$output" | grep -E "SYSTEM_CONTAINER=true"

# Azure Functions (NodeJS) cloud image
output=$(
  docker run --interactive --tty --rm \
    --volume "$PWD":/project:ro \
    --workdir /project \
    --entrypoint /project/scripts/makeops/system-detect/system-detect-docker-entrypoint.test.sh \
    mcr.microsoft.com/azure-functions/node:4-node16 \
      /bin/sh -c \
        ./scripts/makeops/system-detect/system-detect.sh
)
echo "$output" | grep -E "SYSTEM_DIST=debian"
echo "$output" | grep -E "SYSTEM_VERSION=11.1"
echo "$output" | grep -E "SYSTEM_CONTAINER=true"

# Azure Functions (.NET) cloud image
output=$(
  docker run --interactive --tty --rm \
    --volume "$PWD":/project:ro \
    --workdir /project \
    --entrypoint /project/scripts/makeops/system-detect/system-detect-docker-entrypoint.test.sh \
    mcr.microsoft.com/azure-functions/dotnet:4 \
      /bin/sh -c \
        ./scripts/makeops/system-detect/system-detect.sh
)
echo "$output" | grep -E "SYSTEM_DIST=debian"
echo "$output" | grep -E "SYSTEM_VERSION=11.1"
echo "$output" | grep -E "SYSTEM_CONTAINER=true"

# --------------------------------------

# Google Cloud SDK cloud image
output=$(
  docker run --interactive --tty --rm \
    --volume "$PWD":/project:ro \
    --workdir /project \
    --entrypoint /project/scripts/makeops/system-detect/system-detect-docker-entrypoint.test.sh \
    google/cloud-sdk:378.0.0 \
      /bin/sh -c \
        ./scripts/makeops/system-detect/system-detect.sh
)
echo "$output" | grep -E "SYSTEM_DIST=debian"
echo "$output" | grep -E "SYSTEM_VERSION=10.11"
echo "$output" | grep -E "SYSTEM_CONTAINER=true"

# Google Cloud SDK (slim) cloud image
output=$(
  docker run --interactive --tty --rm \
    --volume "$PWD":/project:ro \
    --workdir /project \
    --entrypoint /project/scripts/makeops/system-detect/system-detect-docker-entrypoint.test.sh \
    google/cloud-sdk:378.0.0-slim \
      /bin/sh -c \
        ./scripts/makeops/system-detect/system-detect.sh
)
echo "$output" | grep -E "SYSTEM_DIST=debian"
echo "$output" | grep -E "SYSTEM_VERSION=10.11"
echo "$output" | grep -E "SYSTEM_CONTAINER=true"

# Google Cloud SDK (Alpine) cloud image
output=$(
  docker run --interactive --tty --rm \
    --volume "$PWD":/project:ro \
    --workdir /project \
    --entrypoint /project/scripts/makeops/system-detect/system-detect-docker-entrypoint.test.sh \
    google/cloud-sdk:378.0.0-alpine \
      /bin/sh -c \
        ./scripts/makeops/system-detect/system-detect.sh
)
echo "$output" | grep -E "SYSTEM_DIST=alpine"
echo "$output" | grep -E "SYSTEM_VERSION=3.13.8"
echo "$output" | grep -E "SYSTEM_CONTAINER=true"
