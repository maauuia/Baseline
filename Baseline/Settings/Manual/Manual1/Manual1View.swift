import SwiftUI

struct Manual1View: View {
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
                    Text("Enter content relating to profiles")
                        .padding(.leading, 15)
                    
                }
                
                .frame(width: 340, height: 650, alignment: .topLeading)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(35)
                
                //TAB 2
                VStack(alignment: .leading, spacing: 40){
                    Text("")
                    Text("Editing")
                        .bold()
                        .padding(.leading, 15)
                    Image("SignUpGraphics") //sizing and positioning
                        .resizable()
                        .scaledToFill()
                        .frame(height: 225)
                        .clipped()
                    Text("Enter content relating to profiles")
                        .padding(.leading, 15)
                    
                }
                .frame(width: 340, height: 650, alignment: .topLeading)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(35)
                
                //TAB 3
                VStack(alignment: .leading, spacing: 40){
                    Text("")
                    Text("Data")
                        .bold()
                        .padding(.leading, 15)
                    Image("SignUpGraphics") //sizing and positioning
                        .resizable()
                        .scaledToFill()
                        .frame(height: 225)
                        .clipped()
                    Text("Enter content relating to profiles")
                        .padding(.leading, 15)
                    
                }
                .frame(width: 340, height: 650, alignment: .topLeading)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(35)
            }
            .padding()
            .tabViewStyle(.page(indexDisplayMode: .always))
            .navigationTitle("How to add & edit a profile") //header
        }
    }
}
            

#Preview {
    Manual1View()
}
