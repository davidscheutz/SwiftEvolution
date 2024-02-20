import Foundation

extension Optional<String> {
    public func orEmpty() -> String {
        self ?? ""
    }
}

extension String {
    public static let empty = ""
}
