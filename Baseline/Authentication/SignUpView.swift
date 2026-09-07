import SwiftUI
import FirebaseAuth
internal import Combine

//shows the sign up boxes containing the email, pass, and confirm pass
//all inputs stored in variables

@MainActor
final class SignUpEmailViewModel: ObservableObject {
    @Published var email = "" //variables for user input in SignUpEmailView()
    @Published var password = ""
    @Published var confirmpassword = ""
    
    func signUp() async -> AuthDataResultModel? {
        
        //checks if email feild is empty
        guard !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return nil //or does nothing
        }
        
        //checks if password feild is empty
        guard !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return nil
        }
        
        //checks if confirm password feild is empty
        guard !confirmpassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return nil
        }
        
        //checks if password is the same as the confirm password
        guard password == confirmpassword else {
            print("Pass do not match")
            return nil
        }
        
        do {
            let user = try await AuthenticationManager.shared.createUser(
                email: email,
                password: password
            )
            return user
        } catch {
            print("Signup Error:", error)
            return nil
        }
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


struct SignUpEmailView: View {
    @StateObject private var viewModel = SignUpEmailViewModel()
    @State private var createdAccount = false
    @State private var visibleAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                //photo placeholder for log in graphic
                Image("SignUpGraphics")
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
                
                //password confirmation textbox
                HStack {
                    Image(systemName: "key")
                        .foregroundStyle(.secondary)
                    SecureField("Confirm password", text:  $viewModel.confirmpassword) //secure feild to suit safe password entering & stored in variable confirmpassword
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
                        if let _ = await viewModel.signUp() { //all the inputs are put through signUp() above which check to make sure they are not empty and that the passwords match
                            createdAccount = true
                        } else {
                            visibleAlert = true
                        }
                    }
                } label: {
                    Text("Sign Up") //button text
                        .font(.headline)
                        .foregroundStyle(.gray)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.regularMaterial)
                        .cornerRadius(20)
                }
                .alert(isPresented: $visibleAlert) {
                    Alert(
                        title: Text("Trouble creating account"),
                        message: Text("This account may already exist " +
                                      "or username or password is incorrect."))
                }
            }
            .fullScreenCover(isPresented: $createdAccount) { //if the createdAccount is equal to true then user is sent to matches page
                NavigationBar()
            }
            .padding()
           
        }
        .navigationTitle("Sign Up")
    }
    
    struct SignUpEmailView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationStack {
                SignUpEmailView()
            }
        }
    }

}
