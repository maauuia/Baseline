import SwiftUI

//Theme tab - user visible


struct ThemesView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                VStack (alignment: .leading) {
                    List(themeColors) { item in HStack { //shows all colours from BGcolours
                        Text(item.name)
                        
                        Spacer()
                        
                        if item.color == themeManager.selectedColor { //if item is equal to colour chosen
                            Image(systemName: "checkmark") //add a checkmark
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle()) // Makes the entire row tappable
                    .onTapGesture {
                        themeManager.selectedColor = item.color
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Themes")
        }
    }
}
#Preview {
    ThemesView()
}

