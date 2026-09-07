import SwiftUI
import FirebaseFirestore

// Gallery - user visible

//creates an ID per profile and is stored in variable 'id'
struct ProfileAssigner: Identifiable, Codable {
    @DocumentID var id: String?
    var playerName: String?
    
}


//main content
struct GalleryView: View {
    @State private var profiles: [ProfileAssigner] = []
    
    let columns = [ //column layout (3)
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack{
            ZStack{
                GradientBackground()
                VStack{
                    ScrollView{ //moves the page up and down for the content to be accessible
                        LazyVGrid(columns: columns, spacing: 20 ) {
                            ForEach(profiles) { profile in //for loop - no repeating profile ID = unique
                                if let id = profile.id {
                                    NavigationLink( destination: ProfileViewer(profileID: id, profiles: $profiles)){ //profiles: $profiles added
                                        Image("defaultPFP") //because of paywall limitation
                                            .resizable()
                                            .scaledToFill()
                                            .clipped()
                                            .aspectRatio(1, contentMode: .fit)
                                            .cornerRadius(15)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
                .toolbar { //button location Toolbar > Navigation title > Body/content
                    ToolbarItem(placement: .navigationBarTrailing) { //stits in right corner
                        Button(action: addProfile) { //when pressed goes to function
                            Image(systemName: "plus.circle.fill") //+ symbol
                            
                .navigationTitle("Profiles") //title of page
                        }
                    }
                }
            }
            .onAppear{ //ADDED
                loadProfiles()
            }
        }
    }
    //ADDED
    func loadProfiles() {
        let db = Firestore.firestore() //open database
        db.collection("profiles").getDocuments { snapshot, error in //retrieve docuemnts in profiles
            if error != nil { //if there is an error return error if not, code continues
                print("error collecting profile") //print debug text
                return
            }
            if let documents = snapshot?.documents { //returns array of all documents
                self.profiles = documents.compactMap { doc -> ProfileAssigner? in //turns docs into ProfileAssigner
                    try? doc.data(as: ProfileAssigner.self) //then tries to get all data from ProfileAssigner
                }
            }
        }
    }
       //CHANGED
    func addProfile() {
        let db = Firestore.firestore()
        let newID = UUID().uuidString //makes a new ID
        
        let newProfile = ProfileAssigner(id: newID) //creates a ProfileAssigner to the ID made
        profiles.insert(newProfile, at: 0) //makes a new profile at the top corner of the list
        
        db.collection("profiles").document(newID).setData([ //puts it into the document in profiles in Firebase
            "createdAt": Timestamp()
        ])
    }
}
        

//preview - not needed in main code
#Preview {
    GalleryView()
        .environmentObject(ThemeManager())
}
