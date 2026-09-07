import SwiftUI
import FirebaseCore

@main
struct BaselineApp: App {
    @StateObject private var themeManager = ThemeManager()
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            RootView()
                
        }
    }
}
