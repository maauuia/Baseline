import SwiftUI
import FirebaseAuth
internal import Combine

@MainActor
final class SignInEmailViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    func signInEmail() async throws -> AuthDataResultModel {
        let authResult = try await Auth.auth().signIn(
            withEmail: email,
            password: password
        )
        return AuthDataResultModel(user: authResult.user)
    }

}
    

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


struct SignInEmailView: View {
    @StateObject private var viewModel = SignInEmailViewModel()
    @State private var loggedinAccount = false
    @State private var visibleAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                //photo placeholder for log in graphic - reused from SignUpView()
                Image("SignUpGraphics") //sizing and positioning
                    .resizable()
                    .scaledToFill()
                    .frame(height: 225)
                    .clipped()
                Spacer()
                
                //email textbox
                HStack {
                    Image(systemName: "person") //email icon to the left
                        .foregroundStyle(.secondary)
                    TextField("Username", text:  $viewModel.email) //normal text feild that writes to variable email
                }
                .padding() //design of textbox
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                )
                
                //password textbox
                HStack {
                    Image(systemName: "key")
                        .foregroundStyle(.secondary)
                    SecureField("Password", text:  $viewModel.password) //secure feild to suit safe password entering & stored in variable password
                }
                .padding()
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                )
                
                Spacer()
                //button to create the email account
                Button {
                    Task {
                        do {
                            _ = try await viewModel.signInEmail() //goes to function in class above
                            loggedinAccount = true //sets variable to true which triggers full screen cover to show
                        } catch {
                            visibleAlert = true //if returns an error then the alert appears
                        }
                    }
                } label: {
                    Text("Sign In") //button text
                        .font(.headline)
                        .foregroundStyle(.gray)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.regularMaterial)
                        .cornerRadius(20)
                }
                .alert(isPresented: $visibleAlert) { //alert pop up
                    Alert(
                        title: Text("Trouble logging in"), //content of the alert
                        message: Text("Username or password is incorrect." +
                                      "Please try again."))
                }
                .fullScreenCover(isPresented: $loggedinAccount) { //if the existing account is found is equal to true then user is sent to matches page
                    NavigationBar()
                }
            }
        }
        .padding()
        .navigationTitle("Sign In")
    }
}

struct SignUpEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignInEmailView()
                }
            }
        }
