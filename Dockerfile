# Set Default Arguments - will be overwritten by the GH action
ARG BUILDER_IMAGE=swift:focal
ARG RUNTIME_IMAGE=swift:focal

# builder image
FROM ${BUILDER_IMAGE} AS builder
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libxml2-dev \
 && rm -r /var/lib/apt/lists/*

RUN git clone https://github.com/realm/SwiftLint.git
WORKDIR /SwiftLint
# Defaul SwiftLint version - will be overwritten by the GH action
ARG SWIFTLINT_VERSION=0.53.0
RUN git checkout ${SWIFTLINT_VERSION}

RUN swift package update
ARG SWIFT_FLAGS="-c release -Xswiftc -static-stdlib -Xlinker -lCFURLSessionInterface -Xlinker -lCFXMLInterface -Xlinker -lcurl -Xlinker -lxml2 -Xswiftc -I. -Xlinker -fuse-ld=lld -Xlinker -L/usr/lib/swift/linux"
RUN swift build ${SWIFT_FLAGS} --product swiftlint
RUN mkdir -p /executables
RUN install -v `swift build ${SWIFT_FLAGS} --show-bin-path`/swiftlint /executables

# runtime image
FROM ${RUNTIME_IMAGE}

RUN apt-get update && apt-get install -y \
    libcurl4 \
    libxml2 \
 && rm -r /var/lib/apt/lists/*

COPY --from=builder /usr/lib/libsourcekitdInProc.so /usr/lib
COPY --from=builder /usr/lib/swift/linux/libBlocksRuntime.so /usr/lib
COPY --from=builder /usr/lib/swift/linux/libdispatch.so /usr/lib
COPY --from=builder /usr/lib/swift/linux/libswiftCore.so /usr/lib
COPY --from=builder /executables/* /usr/bin

# Print Installed Swift & SwiftLint Version
RUN swift --version
RUN swiftlint version
