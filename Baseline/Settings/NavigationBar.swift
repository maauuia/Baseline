import SwiftUI

//Navigator

struct NavigationBar: View {
    
    var body: some View {
        TabView{ //Tab bar
            MatchhomeView()
            // For the Match icons
                .tabItem{
                    Label("Matches", systemImage: "figure.tennis") //icon graphics
                }
            GalleryView()
                .tabItem{
                    Label("Profiles", systemImage: "person.fill")
                }
            
            SettingsView (showSignInView: .constant(false))
                .tabItem{
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}
