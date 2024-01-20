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
    
    func testSynchronizedArray() async {
        let array = SynchronizedArray<Int>()
        
        // TODO: add coverage for all operations
        let randomOperation = {
            switch Int.random(in: 1...5) {
            case 1: _ = array.count
            case 2: array.append(newElement: .random(in: 1...99_999))
            case 3: array.mutate { if !$0.isEmpty { $0.removeLast() } }
            case 4: array.mutate { $0.insert(.random(in: 1...99_999), at: $0.indices.randomElement() ?? 0) }
            case 5: array.mutate { if !$0.isEmpty { _ = $0[$0.indices.randomElement()!] } }
            default: XCTFail("Undefined array operation")
            }
        }
        
        let performWork: @Sendable () -> Void = {
            (1...100).forEach { _ in
                randomOperation()
            }
        }
        
        DispatchQueue.global(qos: .background).async(execute: performWork)
        DispatchQueue.global(qos: .utility).async(execute: performWork)
        DispatchQueue.global(qos: .default).async(execute: performWork)
    }
}
