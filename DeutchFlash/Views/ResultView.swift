import SwiftUI

struct ResultView: View {
    
    let score: Int
    let total: Int
    let category: String
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 30) {
            
            Text("Test Tamamlandı 🎉")
                .font(.largeTitle)
                .bold()
            
            Text("Toplam Puanın")
                .font(.title3)
            
            Text("\(score) / \(total)")
                .font(.system(size: 50))
                .bold()
            
            Text(resultMessage())
                .font(.title3)
                .foregroundColor(.gray)
            
            Spacer()
            
            // Tekrar Dene
            NavigationLink {
                QuizView(category: category)
            } label: {
                Text("Tekrar Dene")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
            
            // Kategoriye Dön
            Button {
                dismiss()
            } label: {
                Text("Kategoriye Dön")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(16)
            }
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .navigationBarBackButtonHidden(true)
    }
    
    func resultMessage() -> String {
        let percentage = Double(score) / Double(total)
        
        switch percentage {
        case 0.9...1.0:
            return "Mükemmel! 🔥"
        case 0.7..<0.9:
            return "Çok iyi! 👏"
        case 0.5..<0.7:
            return "Fena değil 👍"
        default:
            return "Tekrar denemelisin 💪"
        }
    }
}
