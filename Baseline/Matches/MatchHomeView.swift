import SwiftUI
import FirebaseFirestore


//creates an ID per profile and is stored in variable 'id'
struct MatchAssigner: Identifiable, Codable {
    @DocumentID var id: String? //POTENTIALLY CHANGE VARIABLE NAME TO AVOID BUGS
}



//main content
struct MatchHomeView: View {
    @State private var matches: [MatchAssigner] = []
   

    let columns = [ //column layout (1)
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack{
            ZStack{
                GradientBackground()
                VStack{
                    ScrollView{ //moves the page up and down for the content to be accessible
                        LazyVGrid(columns: columns, spacing: 20 ) {
                            ForEach(matches) { match in //for loop - no repeating profile ID = unique
                                if let id = match.id {
                                    NavigationLink( destination: ConfigureMatchView()){
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(.thinMaterial)
                                                .stroke(Color.white.opacity(0.3), lineWidth: 2)
                                            HStack{
                                                HStack{
                                                    Image("defaultPFP")
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 75, height: 75)
                                                        .clipped()
                                                        .cornerRadius(10)
                                                    Image("defaultPFP")
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 75, height: 75)
                                                        .clipped()
                                                        .cornerRadius(10)
                                                }
                                                .padding(16)
                                                VStack(alignment: .leading) {
                                                    Text("Match name") //enter variable for match name
                                                        .bold()
                                                        .font(.system(size: 13))
                                                        .foregroundColor(.black)
                                                    Text("Player 1 name") //enter variable for player 1 name
                                                        .font(.system(size: 13))
                                                        .foregroundColor(.black)
                                                    Text("Player 2 name") //enter variable for player 2 name
                                                        .font(.system(size: 13))
                                                        .foregroundColor(.black)
                                                    Text("01/01/2000") //enter variable for date and time
                                                        .font(.system(size: 13))
                                                        .foregroundColor(.black)
                                                    Text("Singles match")
                                                        .font(.system(size: 13))
                                                        .foregroundColor(.black)
                                                }
                                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                                .padding(16)
                                            }
                                            
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
                .navigationTitle("Matches")
                .toolbar { //button location Toolbar > Navigation title > Body/content
                    ToolbarItem(placement: .navigationBarTrailing) {  NavigationLink(
                        destination: ConfigureMatchView(
                            onMatchCreated: {
                                let newMatch = MatchAssigner(id: UUID().uuidString)
                                matches.insert(newMatch, at: 0)
                            }
                        )
                    ) {
                        Image(systemName: "plus.circle.fill")
                    }
                    
                    }
                }
            }
        }
        
    }
}
        

//preview - not needed in main code
#Preview {
    MatchHomeView()
        .environmentObject(ThemeManager())
}

