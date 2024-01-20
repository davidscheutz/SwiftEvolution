import Foundation
import XCTest

func XCTAssertIsEmpty(_ value: String?) {
    XCTAssertEqual(value?.isEmpty, true)
}
