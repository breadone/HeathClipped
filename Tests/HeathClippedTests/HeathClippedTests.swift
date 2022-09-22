import XCTest
@testable import HeathClipped

final class HeathClippedTests: XCTestCase {
    func testDate() throws {
        let link = try getHeathCliff(year: "2022", month: "09", day: "20")
        XCTAssert(link == "https://assets.amuniversal.com/98a93ef0178c013bc48f005056a9545d")
    }
}
