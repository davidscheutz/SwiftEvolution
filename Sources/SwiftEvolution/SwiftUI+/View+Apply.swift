import SwiftUI

extension View {
    @ViewBuilder
    public func apply<T, Result: View>(_ value: T?, @ViewBuilder apply: @escaping (Self, T) -> Result) -> some View {
        if let value {
            apply(self, value)
        } else {
            self
        }
    }
    
    @ViewBuilder
    public func apply<Result: View>(if shouldApply: Bool, @ViewBuilder apply: @escaping (Self) -> Result) -> some View {
        if shouldApply {
            apply(self)
        } else {
            self
        }
    }
}
