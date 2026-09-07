import SwiftUI


struct RootView: View {


    @StateObject private var auth = AuthStateManager()
    @StateObject private var themeManager = ThemeManager()

    var body: some View {

        Group {
            if auth.isSignedIn {
                NavigationView {  //if signed in, content view is shown
                    ContentView()
                }
            } else {
                NavigationView { //if not signed in, authentication view is shown
                    AuthenticationView()
                }
               
            }
        }
        //these can be accessed anywhere
        .environmentObject(auth) // allows it to be accessed in SettingsView
        .environmentObject(themeManager) //for global themes
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView() //preview - can be ignored
            .environmentObject(AuthStateManager()) //only for testing, and so the preview does not crash when canvas is used
    }
}


