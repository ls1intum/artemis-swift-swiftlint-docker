# Swift with SwiftLint for Artemis programming exercises
# Using noble (Ubuntu 24.04) for GLIBC 2.38+ required by SwiftLint pre-built binaries
ARG SWIFT_IMAGE=swift:6.2-noble

FROM ${SWIFT_IMAGE}

ARG SWIFTLINT_VERSION=0.63.1
ARG TARGETARCH

# Install dependencies and SwiftLint
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    libcurl4 \
    libxml2 \
 && rm -rf /var/lib/apt/lists/* \
 && ARCH=$([ "$TARGETARCH" = "arm64" ] && echo "arm64" || echo "amd64") \
 && curl -fsSL "https://github.com/realm/SwiftLint/releases/download/${SWIFTLINT_VERSION}/swiftlint_linux_${ARCH}.zip" -o /tmp/swiftlint.zip \
 && unzip /tmp/swiftlint.zip -d /usr/local/bin \
 && rm /tmp/swiftlint.zip \
 && chmod +x /usr/local/bin/swiftlint

# Verify installations
RUN swift --version && swiftlint version
