import SwiftUI
import FirebaseFirestore
import PhotosUI

//creates a view for the profiles when clicked - links to gallery view

struct ProfileViewer: View {
    let profileID: String
    @Binding var profiles: [ProfileAssigner] //ADDED
    
    //all variables - for the toolbar
    //NAME
    @State private var nameAlert = false
    @State private var playerName = ""
    @State private var tempName = ""
    //PFP ADD
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    @State private var showPhotoPicker = false
    //DELETE PROFILE
    @State private var showDeleteProfile = false
    
    @Environment(\.dismiss) var dismiss //goes back to profiles
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //PROFILE
    var generalProfile: some View{
        Group {
            if let selectedImage {
                selectedImage
                    .resizable()
                    .scaledToFill()
            } else {
                Image("defaultPFP")  //placeholder for profile picture import
                    .resizable()
                    .scaledToFill()
            }
            
        }
        .frame(width: 180, height: 180)
        .cornerRadius(15)
        .clipped()
    }
    
    //MATCHES
    var matchesProfile: some View {
        VStack(alignment: .leading, spacing: 3){
            Text("Matches") //title
                .font(.title2)
                .fontWeight(.bold)
            Text("Information - placeholder for matches") //placeholder for match data NEED TO BIND
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) //alignment and padding to fit screen
        
    }
    
    //STATS
    var statsProfile: some View {
        VStack(alignment: .leading, spacing: 3){
            Text("Statistics") //title
                .font(.title2)
                .fontWeight(.bold)
            Text("Information - placeholder for statistics") //placeholder for stats NEED TO BIND
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) //alignment and padding to fit screen
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //GENERAL CONTENT
    var body: some View {
        NavigationStack{
            ZStack{
                GradientBackground()
                //background gradient wallpaper
                ScrollView { //scrollable page
                    VStack{
                        Text(playerName.isEmpty ? "No player name" : playerName)//current name
                            .font(.title2)
                        //PROFILE
                        generalProfile
                        Spacer ()
                        //MATCHES
                        matchesProfile
                        Spacer ()
                        //STATISTICS
                        statsProfile
                        
                        Spacer()
                    }
                    .navigationTitle("Profile") //header
                    .padding()
                    .toolbar { //button location Toolbar > Navigation title > Body/content
                        ToolbarItem(placement: .navigationBarTrailing) { //stits in right corner
                            Menu {
                                Button("Change name") {
                                    print("Name changing")
                                    nameAlert = true
                                }
                                
                                Button("Change profile picture") {
                                    showPhotoPicker = true
                                }
                                
                                Button("Remove profile picture") {
                                    print("Profile Picture removed")
                                    selectedImage = nil
                                }
                                
                                Button("Delete profile", role: .destructive) {
                                    print("Profile Deleted selected")
                                    showDeleteProfile = true
                                }
                            } label: {
                                Image(systemName: "line.3.horizontal")
                            }
                        }
                    }
                    .alert("Change Name", isPresented: $nameAlert) {
                        TextField("Enter name", text: $tempName)
                        
                        Button("Change") {
                            playerName = tempName
                            saveProfileName()
                        }
                        
                        Button("Back", role: .cancel) { }
                    } message: {
                        Text("Enter the players name:")
                    }
                    .photosPicker(isPresented: $showPhotoPicker, selection: $selectedItem)
                    
                    .onChange(of: selectedItem) {
                        Task {
                            if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                selectedImage = Image(uiImage: uiImage)
                            }
                        }
                    }
                    
                    .alert("Delete this profile?", isPresented: $showDeleteProfile) {
                        Button("Delete") { //delete button
                            
                            deleteProfile() //function is triggered
                            //passes profileID
                        }
                        Button("Back", role: .cancel) { } //cancel button
                    } message: {
                        Text("Confirm to delete. This cannot be undone.")
                    }
                    
                    .onAppear {
                        loadProfileName()
                    }
                    
                }
            }
            
        }
        
    }
    func saveProfileName() {
        let db = Firestore.firestore() //open database
        db.collection("profiles").document(profileID).setData([ //path of document
            "playerName": playerName //set name VAR PLAYERNAME into the name spot
                                                              ], merge: true) //so it does not override everything
    }
    
    func loadProfileName() {
        let db = Firestore.firestore() //open database
        db.collection("profiles").document(profileID).getDocument { snapshot, error in //request data
            guard let data = snapshot?.data() else { return } //if no data found return nothing
            
            playerName = data["playerName"] as? String ?? "" //ensures its a string when it finds data in playerName directory
        }
    }
    
    func deleteProfile() {
        let db = Firestore.firestore()
        
        db.collection("profiles").document(profileID).delete { error in //goes to profiles and deletes profileID
            if error != nil { //if something does not work
                print("Error deleting profile") //debug response
            } else {
                print("Profile  deleted") //debug response
                
                //ADDED
                if let index = profiles.firstIndex(where: { $0.id == profileID }) { //finds selected profile in the gallery
                    profiles.remove(at: index) //deletes it
                }
                dismiss() //sends user back to gallery
            }
        }
    }
}




#Preview {
    ProfileViewer(profileID: "", profiles: .constant([]))
}


