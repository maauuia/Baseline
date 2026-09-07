import SwiftUI
internal import Combine

class ThemeManager: ObservableObject {
    @Published var selectedColor: Color = themeColors.first!.color
}
