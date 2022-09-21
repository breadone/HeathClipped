import XCTest
@testable import HeathClipped

final class HeathClippedTests: XCTestCase {
    func testYea() throws {
        print(try getHeathCliff(year: "2022", month: "09", day: "20"))
    }
    
    func testDate() {
        print(Date())
    }
}
