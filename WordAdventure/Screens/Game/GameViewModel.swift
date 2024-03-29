//
//  DailyGameViewModel.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 30.11.2023.
//

import Foundation


class GameViewModel: ObservableObject{
    let firestore = FirebaseManager.shared.firestore
    let soundManager = SoundManager.shared
    @Published var questions: [Question] = []
    @Published var allLetters: [String] = letters
    @Published var index: Int = 0
    @Published var answer: String = ""
    @Published var isLoading: Bool = false
    @Published var showNoQuestionAlert: Bool = false
    @Published var showCloseAlert: Bool = false
    @Published var showSomethingWrongAlert: Bool = false
    @Published var screen: GameScreenType = .info
    
    var currentLetter: String {
        allLetters[index]
    }
    
    var currentQuestion: Question? {
        questions.first { $0.letter == allLetters[index].localizedLowercased() }
    }
    
    func closeInfoScreen(){
        screen = .game
    }
    
    func showResultScreen(){
        screen = .result
    }
    
    func checkAnswer() {
        if let currentIndex = questions.firstIndex(where: { $0.letter == allLetters[index].localizedLowercased() }) {
            if answer.lowercased() == "bitir" {
                screen = .result
            }
            else if answer == "" || answer.lowercased() == "pas" {
                questions[currentIndex].answerState = AnswerState.isPassed
                soundManager.playSound(sound: .pass)
            } else if answer.localizedLowercased() == questions[currentIndex].word.localizedLowercased() {
                questions[currentIndex].answerState = AnswerState.isCorrect
                questions[currentIndex].userAnswer = answer
                soundManager.playSound(sound: .correct)
            } else {
                questions[currentIndex].answerState = AnswerState.isWrong
                questions[currentIndex].userAnswer = answer
                soundManager.playSound(sound: .wrong)
            }
        }
        answer = ""
        if questions.first(where: {$0.userAnswer == "-"}) != nil {
            getNextQuestion()
        } else {
            showResultScreen()
        }
    }

    func getNextQuestion() {
        while !allLetters.isEmpty {
            index = (index + 1) % allLetters.count
            let currentIndex = questions.firstIndex(where: { $0.letter == allLetters[index].localizedLowercased() })

            if let currentIndex,
               questions[currentIndex].answerState == AnswerState.none || questions[currentIndex].answerState == AnswerState.isPassed {
                return
            }
        }
        screen = .result
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
                    let dataError = NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "No data found"])
                    completion(dataError)
                }
            }
        }
    }
}
