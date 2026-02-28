import SwiftUI

struct HomeView: View {
    
    let categories = [
        ("food", "🍔 Yemek"),
        ("animals", "🐶 Hayvanlar"),
        ("house", "🏠 Ev"),
        ("clothes", "👕 Giysi"),
        ("family", "👨‍👩‍👧 Aile"),
        ("transport", "🚗 Ulaşım"),
        ("colors", "🎨 Renkler"),
        ("body", "🧍 Vücut"),
        ("professions", "💼 Meslekler"),
        ("everyday", "📦 Günlük")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Deutsch Flash")
                .font(.largeTitle)
                .bold()
                .padding(.top)
            
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(categories, id: \.0) { category in
                        
                        NavigationLink {
                            QuizView(category: category.0)
                        } label: {
                            Text(category.1)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(16)
                                .shadow(radius: 3)
                        }
                    }
                }
                .padding()
            }
            
            Spacer()
        }
        .background(Color(.systemGroupedBackground))
    }
}
