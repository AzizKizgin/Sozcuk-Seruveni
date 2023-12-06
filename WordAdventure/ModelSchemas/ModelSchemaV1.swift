//
//  ModelSchemaV1.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 30.11.2023.
//

import Foundation
import SwiftData

enum ModelSchemaV1: VersionedSchema{
    static var versionIdentifier = Schema.Version(
        1,
        0,
        0
    )
    
    static var models: [any PersistentModel.Type]{
        [
            Word.self
        ]
    }

    @Model
    final class Word {
        var letter: String
        var meaning: String
        @Attribute(.unique) var word: String
        
        init(letter: String, meaning: String, word: String) {
            self.letter = letter
            self.meaning = meaning
            self.word = word
        }
    }
    
    @Model
    class DailyGame{
        @Attribute(.unique) var date: Date
        var dailyGameQuestions: [Question]
        var remainingTime: String
        init(date: Date, dailyGameQuestions: [Question],remainingTime: String) {
            self.date = date
            self.dailyGameQuestions = dailyGameQuestions
            self.remainingTime = remainingTime
        }
    }

}
