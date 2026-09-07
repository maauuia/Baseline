//set up the match
//match home view --> configure match (!) --> point counter view (<--> match info view)
//all inputs will be held in firebase and displayed as a string in match info view - only serves as informative page
import SwiftUI
import FirebaseFirestore

struct ConfigureMatchView: View {

    
    @State private var matchName = "" //name of match
    @State private var matchType = "" //type of match

    @State private var chosenPlayer1 = ""
    @State private var chosenPlayer2 = ""
    @State private var pointScoringType = "" //scoring type
    @State private var matchCourtType = "" //court type
    @State private var courtSurfaceType = ""
    @State private var matchDate = Date() //stores the date
    @State private var games = 0
    @State private var sets = 0
    
    enum MatchType: String, CaseIterable, Identifiable { //for the segmented picker
        case singles = "Singles"
        case doubles = "Doubles"
        var id: String { rawValue }
    }
    @State private var selectedMatchType: MatchType = .singles
    
    var onMatchCreated: (() -> Void)? //for navigation button appearance on match screen
    
    @State private var goToPointCounter = false
    
    var buttonOn: Bool {
        // Match name should not be empty
                guard !matchName.trimmingCharacters(in: .whitespaces).isEmpty else { return false } //if textbox is empty, button is off
                
                guard !chosenPlayer1.isEmpty else { return false }
                guard !chosenPlayer2.isEmpty else { return false }
                
                guard !pointScoringType.isEmpty else { return false } //if picker is empty, button is off
                guard !matchCourtType.isEmpty else { return false }
                guard !courtSurfaceType.isEmpty else { return false }
                
                guard games > 0 else { return false } //if stepper is at 0 or less then button is off
                guard sets > 0 else { return false } //if stepper is at 0 or less then button is off
                
                return true //if all statements pass then button is on
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack{
                        
                        VStack{
                            Picker("Match Type", selection: $selectedMatchType) {
                                ForEach(MatchType.allCases) { type in
                                    Text(type.rawValue)
                                        .tag(type)
                                }
                            }
                            .pickerStyle(.segmented)
                            
                            if selectedMatchType == .singles {
                                Text("")
                                VStack {
                                    
                                    HStack {//match name input
                                        Image(systemName: "pencil") //icon
                                            .foregroundStyle(.secondary)
                                        Text("Match name:")
                                        Spacer()
                                        TextField("e.g. Tournament match", text:  $matchName) //stored in matchName
                                    }
                                    
                                    
                                    
                                    HStack {
                                        Image(systemName: "person.fill")
                                            .foregroundStyle(.secondary)
                                        Text("Player 1:")
                                        Spacer()
                                        let players = ["Choose Player 1"] //replace with list of players
                                        Picker("Player 1", selection: $chosenPlayer1) {
                                            ForEach(players, id: \.self) { players in
                                                Text(players)
                                            }
                                        }
                                    }
                                    
                                    HStack {
                                        Image(systemName: "person.fill")
                                            .foregroundStyle(.secondary)
                                        Text("Player 2:")
                                        Spacer()
                                        let players = ["Choose Player 2"] //replace with list of players
                                        Picker("Player 2", selection: $chosenPlayer2) {
                                            ForEach(players, id: \.self) { players in
                                                Text(players)
                                            }
                                        }
                                    }
                                    HStack {
                                        Image(systemName: "calendar")
                                            .foregroundStyle(.secondary)
                                        Text("Date and time:")
                                        Spacer()
                                        DatePicker(
                                            "",
                                            selection: $matchDate,
                                            displayedComponents: [.date, .hourAndMinute]
                                        )
                                        .datePickerStyle(.compact)
                                    }
                                    
                                    
                                    HStack {
                                        Image(systemName: "numbers")
                                            .foregroundStyle(.secondary)
                                        Text("Games per set:")
                                        Stepper("\(games)", value: $games)
                                    }
                                    
                                    HStack {
                                        Image(systemName: "list.number")
                                            .foregroundStyle(.secondary)
                                        Text("Sets to win:")
                                        Stepper("\(sets)", value: $sets)
                                    }
                                    
                                    
                                    HStack {//match name input
                                        Image(systemName: "numbersign") //icon
                                            .foregroundStyle(.secondary)
                                        Text("Scoring:")
                                        Spacer()
                                        let scoringType = ["AD", "No-AD", "Tiebreak"]
                                        Picker("Scoring:", selection: $pointScoringType) {
                                            ForEach(scoringType, id: \.self) { scoringType in
                                                Text(scoringType)
                                            }
                                        }
                                    }
                                    HStack {//match name input
                                        Image(systemName: "sportscourt.fill") //icon
                                            .foregroundStyle(.secondary)
                                        Text("Court type:")
                                        Spacer()
                                        let courtType = ["Indoor", "Outdoor", "Sheltered/Covered"]
                                        Picker("Court:", selection: $matchCourtType) {
                                            ForEach(courtType, id: \.self) { courtType in
                                                Text(courtType)
                                            }
                                        }
                                    }
                                    HStack {//match name input
                                        Image(systemName: "water.waves") //icon
                                            .foregroundStyle(.secondary)
                                        Text("Court surface:")
                                        Spacer()
                                        let courtSurface = ["Hard", "Grass", "Clay", "Carpet"]
                                        Picker("Surface:", selection: $courtSurfaceType) {
                                            ForEach(courtSurface, id: \.self) { courtSurface in
                                                Text(courtSurface)
                                            }
                                        }
                                    }
                                    HStack {//match name input
                                        Image(systemName: "location") //icon
                                            .foregroundStyle(.secondary)
                                        Text("Location:")
                                        Spacer()
                                        Text("N/A")
                                    }
                                }
                                .padding()
                                Text("")
                                
                                Button(action: {
                                    goToPointCounter = true
                                }) {
                                    Text("Create match")
                                        .font(.headline)
                                        .foregroundStyle(.gray)
                                        .frame(height: 55)
                                        .frame(maxWidth: .infinity)
                                        .background(.regularMaterial)
                                        .cornerRadius(20)
                                }
                                .navigationDestination(isPresented: $goToPointCounter) {
                                    PointCounterView()
                                }
                                .disabled(!buttonOn)
                                
                            } else {
                               
                                VStack {
                                    Text("")
                                    Text("")
                                    HStack{
                                        Image(systemName: "lock.badge.clock.fill")
                                        Text("Coming soon...")
                                    }
                                }
                                
                            }
                        }
                        
                    }
                }
                .padding(16)
                .navigationTitle("Configure") //header
            }
            //IF MATCH WAS NOT CREATED AND NAVIGATE BACK WAS PRESSED, NO BOX IS CREATED.
        }
    }
}
#Preview {
    ConfigureMatchView()
}



