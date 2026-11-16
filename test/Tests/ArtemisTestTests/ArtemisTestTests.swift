import SwiftParser
import SwiftSyntax
import Testing
@testable import ArtemisTestLib

@Suite struct ArtemisTestTests {
    /// Uses SwiftSyntax like the structural tests of the Artemis template, so that building this project needs it.
    @Test func parsesSource() {
        _ = Parser.parse(source: "struct ArtemisTest {}")
    }
}
