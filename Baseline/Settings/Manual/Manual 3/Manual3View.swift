import SwiftUI



struct Manual3View: View {
    var body: some View {
        NavigationStack{
            TabView {
                //TAB1
                VStack(alignment: .leading, spacing: 40){
                    Text("")
                    Text("How does it work?")
                        .bold()
                        .padding(.leading, 15)
                    Image("SignUpGraphics") //sizing and positioning
                        .resizable()
                        .scaledToFill()
                        .frame(height: 225)
                        .clipped()
                    Text("Enter content relating to point counter")
                        .padding(.leading, 15)
                    
                }
                    
                    .frame(width: 340, height: 650, alignment: .topLeading)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(35)
                    
                //TAB 2
                VStack(alignment: .leading, spacing: 40){
                    Text("")
                    Text("Specifics")
                        .bold()
                        .padding(.leading, 15)
                    Image("SignUpGraphics") //sizing and positioning
                        .resizable()
                        .scaledToFill()
                        .frame(height: 225)
                        .clipped()
                    Text("Enter content relating to point counter")
                        .padding(.leading, 15)
                    
                }
                .frame(width: 340, height: 650, alignment: .topLeading)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(35)
                
                //TAB 3
                VStack(alignment: .leading, spacing: 40){
                    Text("")
                    Text("Terminology")
                        .bold()
                        .padding(.leading, 15)
                    Image("SignUpGraphics") //sizing and positioning
                        .resizable()
                        .scaledToFill()
                        .frame(height: 225)
                        .clipped()
                    Text("Enter content relating to point counter")
                        .padding(.leading, 15)
                    
                }
                .frame(width: 340, height: 650, alignment: .topLeading)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(35)
            }
            .padding()
            .tabViewStyle(.page(indexDisplayMode: .always))
            .navigationTitle("Point counter function") //header
        }
    }
}

#Preview {
    Manual3View()
}
