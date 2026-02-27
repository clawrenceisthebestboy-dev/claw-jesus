import XCTest
@testable import ClawBackCore

final class DockerServiceTests: XCTestCase {
    func testIsContainerRunning() {
        let service = DockerService.shared
        let isRunning = service.isContainerRunning(name: "openclaw")
        XCTAssertFalse(isRunning, "Container should not be running by default")
    }
}