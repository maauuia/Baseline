import SwiftUI
import FirebaseAuth

//List destinator


struct TableOptions: View {
    @State private var showSignOutAlert = false
    @State private var showDeleteAccAlert = false
    // add another for delete account
    
    let pages = ["Themes","How To","About app"] //page names
    
    @ViewBuilder
    func destinationView(for index: Int) -> some View {
        switch index {
        case 0:
            ThemesView()
        case 1:
            ManualView()
        case 2:
            CreditsView()
        default:
            Text("Unknown page")
        }
    }
    var body: some View {
        NavigationStack {
            List {
                ForEach(pages.indices, id: \.self) { index in
                    NavigationLink(destination: destinationView(for: index)) { //all pages if not 3 or 4
                        Text(pages[index])
                    }
                }
            }
        }
    }
}
