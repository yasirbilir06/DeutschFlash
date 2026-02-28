import Foundation
import SwiftUI
import Combine

class QuizViewModel: ObservableObject {
    
    @Published var allWords: [Word] = []
    @Published var quizWords: [Word] = []
    @Published var currentIndex: Int = 0
    @Published var score: Int = 0
    @Published var options: [Word] = []
    @Published var selectedAnswer: Word? = nil
    @Published var isAnswerCorrect: Bool? = nil
    @Published var isQuizFinished: Bool = false
    
    init() {
        loadWords()
    }
    
    // MARK: - JSON Load
    
    private func loadWords() {
        guard let url = Bundle.main.url(forResource: "words", withExtension: "json") else {
            print("JSON file not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedWords = try JSONDecoder().decode([Word].self, from: data)
            self.allWords = decodedWords
            print("Loaded words: \(allWords.count)")
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    
    // MARK: - Start Quiz
    
    func startQuiz(for category: String) {
        let filtered = allWords.filter { $0.category == category }
        quizWords = Array(filtered.shuffled().prefix(10))
        currentIndex = 0
        score = 0
        generateOptions()
    }
    var isQuizActive: Bool {
        !quizWords.isEmpty && currentIndex < quizWords.count
    }
    
    // MARK: - Current Word
    
    var currentWord: Word? {
        guard currentIndex < quizWords.count else { return nil }
        return quizWords[currentIndex]
    }
    
    // MARK: - Generate Options
    
    private func generateOptions() {
        guard let correctWord = currentWord else { return }
        
        var wrongOptions = allWords
            .filter { $0.german != correctWord.german }
            .shuffled()
            .prefix(3)
        
        options = Array(wrongOptions)
        options.append(correctWord)
        options.shuffle()
    }
    
    // MARK: - Answer Check
    
    func selectAnswer(_ word: Word) {
        guard let correctWord = currentWord else { return }
        
        selectedAnswer = word
        isAnswerCorrect = (word.german == correctWord.german)
        
        if isAnswerCorrect == true {
            score += 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.nextQuestion()
            self.selectedAnswer = nil
            self.isAnswerCorrect = nil
        }
    }
    
    private func nextQuestion() {
        currentIndex += 1
        
        if currentIndex < quizWords.count {
            generateOptions()
        } else {
            isQuizFinished = true
        }
    }
    }

