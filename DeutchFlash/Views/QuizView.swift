import SwiftUI

struct QuizView: View {
    
    @StateObject var vm = QuizViewModel()
    let category: String
    
    var body: some View {
        VStack(spacing: 20) {
            
            if vm.isQuizActive, let word = vm.currentWord {
                
                ProgressView(value: Double(vm.currentIndex),
                             total: Double(vm.quizWords.count))
                    .tint(.green)
                    .padding(.horizontal)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(radius: 5)
                    
                    VStack(spacing: 12) {
                        Text(word.emoji)
                            .font(.system(size: 60))
                        
                        Text(word.turkish)
                            .font(.title2)
                            .bold()
                    }
                    .padding()
                }
                .frame(height: 200)
                .padding(.horizontal)
                
                VStack(spacing: 12) {
                    ForEach(vm.options) { option in
                        Button {
                            vm.selectAnswer(option)
                        } label: {
                            Text("\(option.article) \(option.german)")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(backgroundColor(for: option))
                                .cornerRadius(16)
                        }
                    }
                }
                .padding(.horizontal)
                
                Text("Score: \(vm.score)")
            }
            
            Spacer()
        }
        .background(Color(.systemGroupedBackground))
        .onAppear {
            vm.startQuiz(for: category)
        }
        .navigationTitle("Test")
        .navigationDestination(isPresented: $vm.isQuizFinished) {
            ResultView(
                score: vm.score,
                total: vm.quizWords.count,
                category: category
            )
        }
        
    }
    
    
    func backgroundColor(for option: Word) -> Color {
        guard let selected = vm.selectedAnswer else {
            return Color.blue.opacity(0.2)
        }
        
        if option.german == selected.german {
            return vm.isAnswerCorrect == true ? .green : .red
        }
        
        if option.german == vm.currentWord?.german {
            return .green
        }
        
        return Color.blue.opacity(0.2)
    }
}
