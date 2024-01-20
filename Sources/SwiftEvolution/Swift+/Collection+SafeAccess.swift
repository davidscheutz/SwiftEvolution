import Foundation

public extension Collection {
    
    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
    
    subscript(safe bounds: Range<Index>) -> SubSequence? {
        subsequence(from: bounds.lowerBound, to: bounds.upperBound)
    }
    
    subscript(safe bounds: ClosedRange<Index>) -> SubSequence? {
        subsequence(from: bounds.lowerBound, to: bounds.upperBound)
    }
    
    private func subsequence(from lowerBound: Index, to upperBound: Index) -> SubSequence? {
        guard lowerBound <= upperBound
                && distance(from: startIndex, to: lowerBound) >= 0
                && distance(from: upperBound, to: endIndex) > 0
        else { return nil }
        
        return self[lowerBound...upperBound]
    }
}
