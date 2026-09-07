import SwiftUI

//the page that displays the log in and sign up buttons for the user to select
//- does not have any other function
//log in section links to: AuthManager, SignUpView and SignInView




//view for authenticator
struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuthenticationView()
        }
    }
}


struct AuthenticationView: View {
    var body: some View {
        ZStack {
            LaunchGradientBackground() //Added new background --> check GradientBackground()
                .ignoresSafeArea()
            
            VStack{
                //image of logo
                Image("IconLight") //logo called from assets
                    .resizable()
                    .frame(height: 200)
                    .frame(width: 200)
                    .clipped()
                Spacer()
                Spacer()
                NavigationLink {
                    //sign in button
                    SignInEmailView() 
                } label: {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundStyle(.gray)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.regularMaterial)
                        .cornerRadius(20)
                }
                NavigationLink {
                    //sign up button
                    SignUpEmailView()
                } label: {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundStyle(.gray)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.regularMaterial)
                        .cornerRadius(20)
                }
            }
            
            .padding()
            .navigationTitle("‎ ")
            // make nav title white
        }
        
    }
}
