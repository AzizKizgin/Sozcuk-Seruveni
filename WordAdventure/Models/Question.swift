//
//  Question.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 29.11.2023.
//

import Foundation

enum AnswerState {
    static let none = 0
    static let isCorrect = 1
    static let isWrong = 2
    static let isPassed = 3
}
struct Question: Codable{
    let letter: String
    let meaning: String
    let word: String
    var answerState: Int = 0
    var userAnswer: String = "-"
}
