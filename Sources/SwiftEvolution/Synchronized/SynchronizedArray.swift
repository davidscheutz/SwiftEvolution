import Foundation

public final class SynchronizedArray<Value>: CustomStringConvertible {
    
    private var values: [Value]
    private let concurrentQueue: DispatchQueue
    
    public init(queueLabel: String = UUID().uuidString, values: [Value] = []) {
        self.values = values
        concurrentQueue = DispatchQueue(label: queueLabel, attributes: .concurrent)
    }
    
    public var description: String {
        values.description
    }
    
    public var count: Int {
        concurrentQueue.sync {
            self.values.count
        }
    }
    
    public var isEmpty: Bool {
        concurrentQueue.sync {
            self.values.isEmpty
        }
    }
    
    public var indices: Range<Int> {
        concurrentQueue.sync {
            self.values.indices
        }
    }
    
    public var first: Value? {
        concurrentQueue.sync {
            self.values.first
        }
    }
    
    public var last: Value? {
        concurrentQueue.sync {
            self.values.last
        }
    }
    
    public func append(newElement: Value) {
        concurrentQueue.async(flags: .barrier) {
            self.values.append(newElement)
        }
    }
    
    public func insert(_ newElement: Value, at index: Int) {
        concurrentQueue.async(flags: .barrier) {
            self.values.insert(newElement, at: index)
        }
    }
    
    public func removeFirst() {
        concurrentQueue.async(flags: .barrier) {
            self.values.removeFirst()
        }
    }
    
    public func removeLast() {
        concurrentQueue.async(flags: .barrier) {
            self.values.removeLast()
        }
    }
    
    public func removeAtIndex(index: Int) {
        concurrentQueue.async(flags: .barrier) {
            self.values.remove(at: index)
        }
    }
    
    public subscript(index: Int) -> Value {
        set {
            concurrentQueue.async(flags: .barrier) {
                self.values[index] = newValue
            }
        }
        get {
            concurrentQueue.sync {
                self.values[index]
            }
        }
    }
    
    public func mutate(_ mutate: @escaping (inout [Value]) -> Void) {
        concurrentQueue.async(flags: .barrier) {
            mutate(&self.values)
        }
    }
}
