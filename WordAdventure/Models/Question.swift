//
//  Question.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 29.11.2023.
//

import Foundation

enum AnswerState{
    case isCorrect, isWrong, isPassed, none
}

struct Question{
    let letter: String
    let meaning: String
    let word: String
    var answerState: AnswerState = .none
}
