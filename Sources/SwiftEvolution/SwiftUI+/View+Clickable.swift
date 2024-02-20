import SwiftUI

extension View {
    public func clickable(_ action: (() -> Void)? = nil) -> some View {
        contentShape(Rectangle())
            .apply(action) { view, action in view.onTapGesture(perform: action) }
    }
}
