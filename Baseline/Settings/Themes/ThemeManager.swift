import SwiftUI
internal import Combine

final class ThemeManager: ObservableObject {
    @Published var selectedColor: Color = .blue
}
