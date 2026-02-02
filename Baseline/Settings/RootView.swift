import SwiftUI

struct RootView: View {
    @State private var showSignInView: Bool = false //private variable showSignInView is set to false
    
    var body: some View {
        ZStack {
            NavigationStack {
                SettingsView(showSignInView: $showSignInView) //default screen
            }
        }
        .onAppear {
            let authUser = AuthenticationManager.shared.getAuthenticatedUser() //checks if user is signed in
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView) { //completely replaces page with the log in view
            NavigationStack {
                AuthenticationView()
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView() //preview - can be ignored
    }
}


