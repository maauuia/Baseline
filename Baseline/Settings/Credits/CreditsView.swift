import SwiftUI

struct CreditsView: View {
    var body: some View {
        NavigationStack{
            
            VStack(alignment: .leading, spacing: 3){
                //all content goes here in the vstack
                Text("Authentication")
                    .bold()
                Text("All user authentication (sign in and sign up) was stored and configured through Firebase.")
                Text("")
                Text("Data handling")
                    .bold()
                Text("Majority of relevant data that is used and collected is stored in Firebase, Firestore.")
                Text("")
                Text("Imports used")
                    .bold()
                Text("SwiftUI, Foundation, FirebaseAuth, Combine, FirebaseFirestore, PhotosUI")
                Text("")
                Text("Language used")
                    .bold()
                Text("Swift")
                Text("")
                Text("Firebase package git")
                Text("https://github.com/firebase/firebase-ios-sdk")
                Text("Dependency rule used: Up to Next Major Version 12.5.0 < 13.0.0")
            }
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) //alignment and padding to fit screen
            .navigationTitle("Credits") //header
        }
    }
}

#Preview {
    CreditsView()
}
