//
//  Utils.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 28.11.2023.
//

import Foundation
struct Utils{
    static func getDay() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let dayString = dateFormatter.string(from: date)
        return dayString
    }
    
    static func isDateToday(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let todayComponents = calendar.dateComponents([.year, .month, .day], from: Date())

        return components.year == todayComponents.year &&
               components.month == todayComponents.month &&
               components.day == todayComponents.day
    }
    
    static func getAllWords(completion: @escaping ([Word]?,Error?) -> Void) {
        let firestore = FirebaseManager.shared.firestore
        var questions: [Word] = []
        firestore.collection("Words").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(nil, error)
            } else {
                for document in querySnapshot!.documents {
                    for data in document.data(){
                        if let data = data.value as? [String:String],
                           let letter = data["letter"],
                           let meaning = data["meaning"],
                           let word = data["word"]
                        {
                            let question = Word(letter: letter, meaning: meaning, word: word)
                            questions.append(question)
                        }
                    }
                }
            }
            completion(questions,nil)
        }
    }
    
    static func getLastUpdateDate(completion: @escaping (String?,Error?) -> Void){
        let firestore = FirebaseManager.shared.firestore
        firestore.collection("LastUpdate").document("LastUpdate").getDocument{ (document, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(nil, error)
            } else {
                if let data = document?.data(),
                   let date = data["date"] as? String
                {
                    completion(date, nil)
                }
                else{
                    completion(nil, error)
                }
            }
        }
    }
    
    static func getNormalGameQuestions(words: [Word]) -> [Question]{
        var questions: [Question] = []
        letters.forEach{ letter in
            var shuffledWord = words.filter({$0.letter == letter}).shuffled()[0]
            let question = Question(letter: shuffledWord.letter, meaning: shuffledWord.meaning, word: shuffledWord.word)
            questions.append(question)
        }
        return questions
    }
}
