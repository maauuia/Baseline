import SwiftUI

struct CreditsView: View {
    var body: some View {
        NavigationStack{
            
            VStack(alignment: .leading, spacing: 3){
                //all content goes here in the vstack
                Text("Information")
            }
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) //alignment and padding to fit screen
            .navigationTitle("Credits") //header
        }
    }
}

#Preview {
    CreditsView()
}
