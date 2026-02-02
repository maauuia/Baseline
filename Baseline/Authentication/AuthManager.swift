import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    private init () { }
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel { //all link to signing up and signing in
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    func getAuthenticatedUser() -> User? {
        Auth.auth().currentUser
    }
    func signOut() throws { //links to SettingsView
        try Auth.auth().signOut()
    }
}
