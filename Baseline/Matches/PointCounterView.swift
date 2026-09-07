import SwiftUI

//match name on top
//undo button
//navigation pop up - like in profiles
//score board
//player 1 name
//player 2 name
//pfp of player 1
//pfp of player 2
//score
//the selection of buttons

struct PointCounterView: View {
    @State private var winnerAlert = false
    @State private var deleteMatchAlert = false
    
    @State private var p1Sets = 0 //scores for sets (max 1)
    @State private var p2Sets = 0
    
    @State private var p1Games = 0 //scores for games (max 6)
    @State private var p2Games = 0
    
    @State private var p1Points = 0 //scores for points (0,15,30,40)
    @State private var p2Points = 0
    
    @State private var matchWinner: Int? = nil
    @State private var server: Int = 1 // 1 = player 1, 2 = player 2
    
    @State private var p1counterAce = 0 //p1 stat counter - not used - would have been added to a running total held in firebase.
    @State private var p1counterFServe = 0
    @State private var p1counterSServe = 0
    @State private var p1counterUnforced = 0
    @State private var p1counterDFault = 0
    
    @State private var p2counterAce = 0 //p2 stat counter
    @State private var p2counterFServe = 0
    @State private var p2counterSServe = 0
    @State private var p2counterUnforced = 0
    @State private var p2counterDFault = 0
    
    var leaderboardVar: some View {
        VStack (spacing: 0) {
            HStack{
                Text("Player")
                    .frame(maxWidth: .infinity) //just the headings
                Text("Sets")
                    .frame(maxWidth: .infinity)
                Text("Games")
                    .frame(maxWidth: .infinity)
                Text("Points")
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .bold()
            
            Divider()
            HStack {
                Text("Player 1")
                    .frame(maxWidth: .infinity) //change to player name
                Text("\(p1Sets)")
                    .frame(maxWidth: .infinity)
                Text("\(p1Games)")
                    .frame(maxWidth: .infinity)
                Text("\(p1Points)")
                    .frame(maxWidth: .infinity)
            }
            .padding()
            
            Divider()
            HStack {
                Text("Player 2")
                    .frame(maxWidth: .infinity) //change to player name
                Text("\(p2Sets)")
                    .frame(maxWidth: .infinity)
                Text("\(p2Games)")
                    .frame(maxWidth: .infinity)
                Text("\(p2Points)")
                    .frame(maxWidth: .infinity)
            }
            .padding()
        }
    }
    
    var profilesVar: some View {
        VStack{
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.clear)
                
                HStack{ //Player details
                    Spacer()
                    VStack {
                        HStack {
                            Text("Player 1") //INSERT PLAYER NAME VAR
                                .bold()
                            if matchWinner == 1 {
                                Image(systemName: "crown.fill")
                            }
                        }
                        Image("defaultPFP") //IMAGE VAR
                            .resizable()
                            .scaledToFill()
                            .frame(width: 75, height: 75)
                            .clipped()
                            .cornerRadius(10)
                        
                        Text("")
                        Image(systemName: "tennisball.fill") //if player is serving, system name is visible
                    
                            .opacity(server == 1 ? 1 : 0.2)
                        Text("")
                    }
                    
                    Spacer()
                    Spacer()
                    
                    VStack {
                        HStack{
                            Text("Player 2") //INSERT PLAYER NAME VAR
                                .bold()
                            if matchWinner == 2 {
                                Image(systemName: "crown.fill")
                            }
                        }
                        Image("defaultPFP") //IMAGE VAR
                            .resizable()
                            .scaledToFill()
                            .frame(width: 75, height: 75)
                            .clipped()
                            .cornerRadius(10)
                        
                        Text("")
                        Image(systemName: "tennisball.fill")//if player is serving, system name is visible
                            .opacity(server == 2 ? 1 : 0.2)
                        Text("")
                    }
                    
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 70)
        }
    }
    
    var pointCounterVar: some View {
        HStack(spacing: 16) { //score for set and buttons to change score
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.thinMaterial)
                    .stroke(Color.white.opacity(0.3), lineWidth: 2)
                
                VStack {
                    Text(tennisPoints(p1Points)) //POINT COUNTER VAR
                        .font(.system(size: 45, weight: .bold))
                    Button {
                        addPoint(player: 1)
                        
                    } label: {
                        Text("Ace")
                            .font(.headline)
                            .foregroundStyle(.gray)
                            .frame(height: 40)
                            .frame(width: 150)
                            .background(.thinMaterial)
                            .cornerRadius(20)
                        
                    }
                    Button {
                        //button to display First serve in
                        addPoint(player: 1)
                    } label: {
                        Text("First Serve")
                            .font(.headline)
                            .foregroundStyle(.gray)
                            .frame(height: 40)
                            .frame(width: 150)
                            .background(.thinMaterial)
                            .cornerRadius(20)
                    }
                    Button {
                        //button to display Second serve in
                        addPoint(player: 1)
                    } label: {
                        Text("Second Serve")
                            .font(.headline)
                            .foregroundStyle(.gray)
                            .frame(height: 40)
                            .frame(width: 150)
                            .background(.thinMaterial)
                            .cornerRadius(20)
                    }
                    
                    Button {
                        //button to display Unforced error
                        addPoint(player: 2)
                    } label: {
                        Text("Unforced")
                            .font(.headline)
                            .foregroundStyle(.gray)
                            .frame(height: 40)
                            .frame(width: 150)
                            .background(.thinMaterial)
                            .cornerRadius(20)
                    }
                    
                    Button {
                        //button to display Fault
                        addPoint(player: 2)
                    } label: {
                        Text("Double Fault")
                            .font(.headline)
                            .foregroundStyle(.gray)
                            .frame(height: 40)
                            .frame(width: 150)
                            .background(.thinMaterial)
                            .cornerRadius(20)
                    }
                }
            }
            .frame(maxWidth: .infinity, minHeight: 150)
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.thinMaterial)
                    .stroke(Color.white.opacity(0.3), lineWidth: 2)
                
                VStack {
                    Text(tennisPoints(p2Points)) //POINT COUNTER
                        .font(.system(size: 45, weight: .bold))
                    Button {
                        
                        addPoint(player: 2)
                    } label: {
                        Text("Ace")
                            .font(.headline)
                            .foregroundStyle(.gray)
                            .frame(height: 40)
                            .frame(width: 150)
                            .background(.thinMaterial)
                            .cornerRadius(20)
                        
                    }
                    Button {
                       
                        addPoint(player: 2)
                    } label: {
                        Text("First Serve")
                            .font(.headline)
                            .foregroundStyle(.gray)
                            .frame(height: 40)
                            .frame(width: 150)
                            .background(.thinMaterial)
                            .cornerRadius(20)
                    }
                    Button {
                       
                        addPoint(player: 2)
                    } label: {
                        Text("Second Serve")
                            .font(.headline)
                            .foregroundStyle(.gray)
                            .frame(height: 40)
                            .frame(width: 150)
                            .background(.thinMaterial)
                            .cornerRadius(20)
                    }
                    
                    Button {
                     
                        addPoint(player: 1)
                    } label: {
                        Text("Unforced")
                            .font(.headline)
                            .foregroundStyle(.gray)
                            .frame(height: 40)
                            .frame(width: 150)
                            .background(.thinMaterial)
                            .cornerRadius(20)
                    }
                    
                    Button {
                        
                        addPoint(player: 1)
                    } label: {
                        Text("Double Fault")
                            .font(.headline)
                            .foregroundStyle(.gray)
                            .frame(height: 40)
                            .frame(width: 150)
                            .background(.thinMaterial)
                            .cornerRadius(20)
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 150)
            }
        }
    }

    
    var body: some View {
        NavigationStack{
            ZStack{
                GradientBackground()
                
                VStack{
                    
                    VStack{
                        ZStack { //Scores
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.thinMaterial)
                                .stroke(Color.white.opacity(0.3), lineWidth: 2)
                            
                            leaderboardVar
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 120)
                    }
                    .padding()
                    
                
                    
                    Text("")
                    Text("")
                    Text("")
                    Text("")
                    
                    profilesVar
                    
                    Text("") //Text("") = extra spacing
                    Spacer()
                    
                    pointCounterVar
                    
                    .padding()
                    
                }
                .navigationTitle("Match name")//matchName) //header
                .toolbar { //button location Toolbar > Navigation title > Body/content
                    ToolbarItem(placement: .navigationBarTrailing) { //stits in right corner
                        Menu {
                            NavigationLink( destination: MatchInfoView()) {
                                Text("Match Information")
                                //navigate to match info page
                            }
                            Button("Declare winner") {
                                //declare winner
                                winnerAlert = true
                            }
                            Button("Abort match") {
                                // showMatchDelete = true
                                deleteMatchAlert = true
                            }
                            
                        } label: {
                            Image(systemName: "line.3.horizontal")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button{
                            //undo function
                        } label: {
                            Image(systemName: "arrow.uturn.backward")
                        }
                    }
                }
                .alert("Declare winner", isPresented: $winnerAlert) {
                    
                    Button("Player 1 wins") {
                        matchWinner = 1
                    }
                    Button("Player 2 wins") {
                        matchWinner = 2
                    }
                    
                    Button("Back", role: .cancel) { }
                } message: {
                    Text("Select winner:")
                }
                
                .alert("Delete the match?", isPresented: $deleteMatchAlert) {
                    
                    Button("Delete") {
                        //delete
                    }
                    Button("Back", role: .cancel) { }
                } message: {
                    Text("This cannot be undone")
                }
            }
        }
    }
    func addPoint(player: Int) { //all buttons are linked to add point. no other function.
        
        guard matchWinner == nil else { return } //while matchWinner is false (no winner):

        if player == 1 { //if player in the button is player 1
            p1Points += 1 //+1 to player 1 points
        } else {
            p2Points += 1 //+1 to player 2 points
        }
            
        checkGameWin() //checks if points have reached 4 for either player 1 or player 2
    }
    
    func checkGameWin() { //add point reads this function to see if either players have reached 4 points
        
        // if player 1 wins the game
        if p1Points >= 4 { //if player 1 points are 4 or more, pass through win game to increment games by 1 for player 1
            winGame(player: 1) //passes player 1 through win game
            return
        }
        
        //if player 2 wins the game
        if p2Points >= 4 { //if player 2 points are 4 or more, pass through win game to increment games by 1 for player 2
            winGame(player: 2)
            return
        }
    }
    
    
    func winGame(player: Int) {
        
        if player == 1 {
            p1Games += 1 //1 game point for player 1
        } else {
            p2Games += 1 //1 game point for player 2
        }
        server = (server == 1) ? 2 : 1
        
        resetPoints() //resets the points to start a new game
        checkSetWin() //checks if games are equal to 6 for win
    }

    
    func checkSetWin() {
        
        if p1Games >= 6 { //if the player 1 games count is 6, player 1 is the match winner !
            matchWinner = 1
            p1Sets = 1
        }
        
        if p2Games >= 6 { //if the player 2 games count is 6, player 2 is the match winner !
            matchWinner = 2
            p2Sets = 1
        }
    }
    
    ///////////////////////////////////////////////////////////
    func resetPoints() { //reset points
        p1Points = 0
        p2Points = 0
    }
    ///////////////////////////////////////////////////////////
    
    func matchResultText() -> String {
        guard let winner = matchWinner else { return "" } //sets the matchWinner as winner
        return "winner is \(winner)" //prints winner in debug
    }
    

    
    func tennisPoints(_ points: Int) -> String { //FOR BIG NUMBER POINT COUNTER
        switch points {
        case 0: return "0"
        case 1: return "15"
        case 2: return "30"
        case 3: return "40"
        default: return "0"
        }
    }
    
}

#Preview {
    PointCounterView()
        .environmentObject(ThemeManager())
}


