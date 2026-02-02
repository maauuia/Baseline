import SwiftUI

struct Manual2View: View {
    var body: some View {
        NavigationStack{
            TabView {
                Text("Tab1") //replace with view
                Text("Tab2") //replace with view
                Text("Tab3") //replace with view
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page)
            .navigationTitle("Manual2") //header
        }
    }
}

#Preview {
    Manual2View()
}
