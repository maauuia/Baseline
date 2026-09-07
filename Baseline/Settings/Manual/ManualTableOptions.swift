import SwiftUI

struct ManualTableOptions: View {
    let pages = ["How to add & edit a profile","Creating matches","Point counter function"]
    
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
