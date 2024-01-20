import XCTest
import SwiftEvolution

final class SwiftEvolutionTests: XCTestCase {
    
    func testStringOrEmpty() {
        let value: String? = "value"
        let noValue: String? = nil
        
        XCTAssertEqual(value.orEmpty(), value)
        XCTAssertIsEmpty(noValue.orEmpty())
    }
    
    func testCollectionSafeAccess() {
        let array = ["Safe", "Value", "Access"]
        
        array.indices.forEach { XCTAssertEqual(array[$0], array[safe: $0]) }
        XCTAssertNil(array[safe: array.count])
        XCTAssertNil(array[safe: -1])
        
        XCTAssertEqual(array[safe: 0...0], array[0...0])
        XCTAssertEqual(array[safe: 1...2], array[1...2])
        XCTAssertEqual(array[safe: 2...2], array[2...2])
        XCTAssertNil(array[safe: -1...1])
        XCTAssertNil(array[safe: 1...array.count])
        XCTAssertNil(array[safe: 1..<array.count+1])
        XCTAssertNil(array[safe: Range(uncheckedBounds: (1, array.count))])
    }
}
