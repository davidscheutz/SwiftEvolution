import Foundation

public func executeOnMainThread(_ execute: @escaping () -> Void) {
    if Thread.isMainThread {
        execute()
    } else {
        DispatchQueue.main.async(execute: execute)
    }
}
