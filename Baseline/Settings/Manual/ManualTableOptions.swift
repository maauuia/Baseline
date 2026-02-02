import SwiftUI

struct ManualTableOptions: View {
    let pages = ["Manual 1","Manual 2","Manual 3"]
    
    @ViewBuilder
    func destinationView(for index: Int) -> some View {
        switch index {
        case 0:
            Manual1View()
        case 1:
            Manual2View()
        case 2:
            Manual3View()
        default:
            Text("Unknown page")
        }
    }
    var body: some View {
        NavigationStack {
            List {
                ForEach(pages.indices, id: \.self) { index in
                    NavigationLink(destination: destinationView(for: index)) {
                        Text(pages[index])
                    }
                }
            }
        }
    }
}
