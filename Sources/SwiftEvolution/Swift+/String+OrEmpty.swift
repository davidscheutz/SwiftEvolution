import Foundation

public extension Optional<String> {
    func orEmpty() -> String {
        self ?? ""
    }
}
