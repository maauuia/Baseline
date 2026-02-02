import SwiftUI

//Theme tab - user visible


struct ThemesView: View {
    @State private var selectedColor: Color = themeColors.first!.color
    
    var body: some View {
        NavigationStack {
            ZStack {
                GradientBackground(primaryColor: selectedColor)
                VStack (alignment: .leading) {
                    List(themeColors) { item in HStack {
                        Text(item.name)
                        
                        Spacer()
                        
                        if item.color == selectedColor {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle()) // Makes the entire row tappable
                    .onTapGesture {
                        selectedColor = item.color
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

