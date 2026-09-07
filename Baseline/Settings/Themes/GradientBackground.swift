import SwiftUI

//Gradient background

struct GradientBackground: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var themeManager: ThemeManager

   

    var invertedPrimary: Color { //inverts the primary gradient colour
        colorScheme == .light ? .white : .black
    }

    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [themeManager.selectedColor, invertedPrimary]), //takes the chosen colour and then its complimentary black or white gradient (changes based on system)
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}

struct LaunchGradientBackground: View { //can be called from anywhere due to global variables
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [.black, .white]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .edgesIgnoringSafeArea(.all)
    }
}
