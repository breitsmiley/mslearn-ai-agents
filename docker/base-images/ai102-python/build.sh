#!/bin/bash

#-------------------------------
VERSION=0.0.2
DOCKER_REGISTRY_HOST="breitsmiley"
IMAGE_NAME="ai102-python"
BASIC_TAG_NAME="$DOCKER_REGISTRY_HOST/$IMAGE_NAME"
TAG_LATEST="$BASIC_TAG_NAME:latest"
TAG_VERSION="$BASIC_TAG_NAME:$VERSION"

# Enable Docker Buildx
#if ! docker buildx inspect multi-builder >/dev/null 2>&1; then
#    docker buildx create --name multi-builder --use
#fi

# Switch to the correct driver if needed
docker buildx use multi-builder

# Build and push multi-arch image
##-------------------------------
docker buildx build --platform linux/amd64,linux/arm64 -t ${TAG_LATEST} -t ${TAG_VERSION} . --push
