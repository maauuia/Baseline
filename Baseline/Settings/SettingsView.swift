import SwiftUI
internal import Combine
import FirebaseAuth

@MainActor
final class AuthenticationManagerModel: ObservableObject{ //talks through @StateObject variable AuthenticationManager
    func logOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}


struct SettingsView: View {
    
    @StateObject private var viewModel = AuthenticationManagerModel() //variable view model
    @EnvironmentObject var auth: AuthStateManager //passes as environment - reacts to change
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack{
                    TableOptions() //displays the table made with themes,etc
                    
                    Spacer()
                    VStack{
                        Button { //log out of account
                            Task {
                                do {
                                    try auth.signOut() //function called

                                } catch {
                                    print(error)
                                }
                            }
                        } label: {
                            Text("Sign Out") //button text
                                .font(.headline)
                                .foregroundStyle(.gray)
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(.regularMaterial)
                                .cornerRadius(20)
                        }
                        
                        Button {
                            //delete account placeholder
                            
                        } label: {
                            Text("Delete Account") //button text
                                .font(.headline)
                                .foregroundStyle(.gray)
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(.regularMaterial)
                                .cornerRadius(20)
                        }
                    }
                    .padding()
                }
                .navigationTitle("Settings") //title on top of screen
            }
        }

    }
    
}

