//match name
//enter player 1
//enter player 2
//date and time picker
//set games per set
//set sets to win
//player 1 as server slider?
//choose scoring type
//choose court type
//choose court surface
//select location

//retrieve all data from match

import SwiftUI

struct MatchInfoView: View {
    var body: some View {
        NavigationStack{
            
            VStack(alignment: .leading, spacing: 3){
                //all content goes here in the vstack
                Text("The match was configured")
                    .bold()
                Text("")
                Text("Match type: Singles")
                Text("Match name:") //INSERT VARIABLE
                Text("Player 1:") //INSERT VARIABLE
                Text("Player 2:") //INSERT VARIABLE
                Text("Date and time:") //INSERT VARIABLE
                Text("Games per set:") //INSERT VARIABLE
                Text("Sets to win:") //INSERT VARIABLE
                Text("Scoring:") //INSERT VARIABLE
                Text("Court type:") //INSERT VARIABLE
                Text("Court surface:") //INSERT VARIABLE
                Text("Location: N/A") 
            }
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) //alignment and padding to fit screen
            .navigationTitle("Match Information") //header
        }
    }
}
#Preview {
    MatchInfoView()
}


