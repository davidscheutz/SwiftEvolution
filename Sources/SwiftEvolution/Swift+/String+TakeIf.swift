import Foundation

extension String {
    public func take(if take: Bool) -> String? {
        take ? self : nil
    }
}
