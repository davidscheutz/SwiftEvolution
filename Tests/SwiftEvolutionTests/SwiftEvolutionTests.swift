import XCTest
import SwiftEvolution

final class SwiftEvolutionTests: XCTestCase {
    
    func testStringOrEmpty() {
        let value: String? = "value"
        let noValue: String? = nil
        
        XCTAssertEqual(value.orEmpty(), value)
        XCTAssertIsEmpty(noValue.orEmpty())
    }
}
