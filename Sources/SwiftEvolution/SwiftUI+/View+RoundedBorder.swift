import SwiftUI

extension View {
    public func roundedBorder(_ cornerRadius: CGFloat, color: Color, lineWidth: CGFloat = 1) -> some View {
        self
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(color, lineWidth: lineWidth)
            )
    }
}

#Preview {
    VStack {
        Text("Hello")
            .padding()
            .roundedBorder(10, color: .blue)
        
        Text("Hello")
            .padding()
            .roundedBorder(10, color: .blue, lineWidth: 5)
    }
    .padding()
}
