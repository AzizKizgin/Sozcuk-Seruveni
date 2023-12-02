//
//  DailyGameViewModel.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 30.11.2023.
//

import Foundation


class DailyGameViewModel: ObservableObject{
    let firestore = FirebaseManager.shared.firestore
    @Published var questions: [Question] = []
    @Published var allLetters: [String] = letters
    @Published var index: Int = 0
    @Published var answer: String = ""
    @Published var isLoading: Bool = false
    @Published var showNoQuestionAlert: Bool = false
    @Published var showCloseAlert: Bool = false
    @Published var showFinishModal: Bool = false
    
    var currentLetter: String {
        allLetters[index]
    }
    
    var currentQuestion: Question? {
        questions.first { $0.letter == allLetters[index].lowercased() }
    }
    
    func checkAnswer() {
        if let currentIndex = questions.firstIndex(where: { $0.letter == allLetters[index].lowercased() }) {
            if answer.lowercased() == "bitir" {
                showFinishModal.toggle()
            }
            else if answer == "" {
                questions[currentIndex].answerState = .isPassed
            } else if answer.lowercased() == questions[currentIndex].meaning.lowercased() {
                questions[currentIndex].answerState = .isCorrect
                questions[currentIndex].userAnswer = answer
            } else {
                questions[currentIndex].answerState = .isWrong
                questions[currentIndex].userAnswer = answer
            }
        }
        answer = ""
        getNextQuestion()
    }

    func getNextQuestion() {
        while !allLetters.isEmpty {
            index = (index + 1) % allLetters.count
            let currentIndex = questions.firstIndex(where: { $0.letter == allLetters[index].lowercased() })

            if let currentIndex = currentIndex,
               questions[currentIndex].answerState == .none || questions[currentIndex].answerState == .isPassed {
                return
            }
        }
        showFinishModal.toggle()
    }
    
    func getQuestions(completion: @escaping (Error?) -> Void) {
        let index = String(Int(Utils.getDay()) ?? 0)
        firestore.collection("Daily").document(index).getDocument { (document, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(error)
            } else {
                if let data = document?.data() {
                    for question in data.values {
                        if let questionData = question as? [String: Any],
                            let letter = questionData["letter"] as? String,
                            let meaning = questionData["meaning"] as? String,
                            let word = questionData["word"] as? String
                        {
                            self.questions.append(Question(letter: letter, meaning: meaning, word: word))
                        }
                    }
                    completion(nil)
                } else {
                    let dataError = NSError(domain: "YourDomain", code: 500, userInfo: [NSLocalizedDescriptionKey: "No data found"])
                    completion(dataError)
                }
            }
        }
        isLoading.toggle()
    }
}
