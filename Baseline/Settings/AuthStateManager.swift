import Foundation
internal import Combine
import FirebaseAuth

@MainActor //works on top
final class AuthStateManager: ObservableObject { //observes and updates when changes are made
    
    
    @Published var user: User? //changes in user
    private var handle: AuthStateDidChangeListenerHandle?
    
    init() { //runs when opened
        handle = Auth.auth().addStateDidChangeListener { _, user in //reacts ti changes in logging in and out
            self.user = user // self differenciates between my property and the property in firebase
        }
    }
    
    var isSignedIn: Bool { //looks at if the user is signed in
        user != nil //turns true if user exists
    }
    func signOut() throws {
        try Auth.auth().signOut() //TRIES signs the user out
    }
}


