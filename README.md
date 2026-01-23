# artemis-swift-swiftlint-docker

Docker image for Swift programming exercises on [Artemis](https://github.com/ls1intum/Artemis).

## Overview

This repository provides a Docker image that includes Swift and SwiftLint for automated assessment of Swift programming exercises. The image is designed to work with the Artemis learning platform.

## Current Versions

| Component | Version |
|-----------|---------|
| Swift | 6.2 |
| SwiftLint | 0.63.1 |
| Base Image | Ubuntu 22.04 (Jammy) |

## Usage

### Pull from GitHub Container Registry

```bash
docker pull ghcr.io/ls1intum/artemis-swift-swiftlint-docker:latest
```

### Pull from Docker Hub

```bash
docker pull ls1tum/artemis-swift-swiftlint-docker:latest
```

### Available Tags

- `latest` - Latest stable release
- `swift6.2` - Tagged by Swift version
- `swiftlint0.63.1` - Tagged by SwiftLint version

### Run SwiftLint

```bash
docker run --rm -v $(pwd):/workspace -w /workspace ghcr.io/ls1intum/artemis-swift-swiftlint-docker:latest swiftlint
```

### Run Swift

```bash
docker run --rm -v $(pwd):/workspace -w /workspace ghcr.io/ls1intum/artemis-swift-swiftlint-docker:latest swift build
```

## Building Locally

```bash
docker build -t artemis-swift-swiftlint-docker .
```

With custom versions:

```bash
docker build \
  --build-arg BUILDER_IMAGE=swift:6.2-jammy \
  --build-arg RUNTIME_IMAGE=swift:6.2-jammy \
  --build-arg SWIFTLINT_VERSION=0.63.1 \
  -t artemis-swift-swiftlint-docker .
```

## Architecture Support

The image supports the following architectures:
- `linux/amd64`
- `linux/arm64`

## License

This project is licensed under the MIT License.
