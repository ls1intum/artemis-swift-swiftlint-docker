# artemis-swift-swiftlint-docker

Docker image with Swift and SwiftLint for programming exercises on [Artemis](https://github.com/ls1intum/Artemis).

## Versions

- **Swift**: 6.2
- **SwiftLint**: 0.63.1
- **Base**: Ubuntu 24.04 (Noble)

## Pull

```bash
# the latest build of this Swift version
docker pull ghcr.io/ls1intum/artemis-swift-swiftlint-docker:swift6.2
# a release; the tag is also a tag of this repository
docker pull ghcr.io/ls1intum/artemis-swift-swiftlint-docker:v1.0.0
```

## Cached dependencies

The Swift test template of Artemis depends on [swift-syntax](https://github.com/swiftlang/swift-syntax). The image resolves the
dependencies of `test/Package.swift` once, so that SwiftPM finds the clone in its cache and the builds of the exercises do not
clone it again.

`test/Package.swift` has to declare the same dependencies as `src/main/resources/templates/swift/test/Package.swift` in Artemis.
Artemis compares both on every pull request that changes the template and builds the template in the image without network
access every night.

`legacy/Package.swift` is the test template of exercises that were created before Swift 6.2. It depends on
[swift-junit](https://github.com/allegro/swift-junit) and [swift-ast](https://github.com/yanagiba/swift-ast), which the image
caches as well, so that these exercises keep building without cloning them. Artemis does not check it.

To change a dependency:

1. Change `test/Package.swift` in this repository and merge it.
2. Push a tag `vX.Y.Z` and publish a release for it. The workflow publishes `ls1tum/artemis-swift-swiftlint-docker:vX.Y.Z` and
   `ghcr.io/ls1intum/artemis-swift-swiftlint-docker:vX.Y.Z`. Keep the image tag identical to the tag of this repository.
3. Change the dependency in the template and the image tag in `application.yml` in one pull request in Artemis.
