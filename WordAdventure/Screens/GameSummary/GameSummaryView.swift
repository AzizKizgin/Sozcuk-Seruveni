//
//  GameSummaryView.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 2.12.2023.
//

import SwiftUI
import SwiftData

struct GameSummaryView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var tabSelection = 0
    @Query var savedDailyGame: [DailyGame]
    let questions: [Question]
    let remainingTime: String
    var saveQuestions: Bool = false
    var body: some View {
        TabView(selection: $tabSelection){
            ScoreView(
                correctCount: getQuestionsStats().correctCount,
                wrongCount: getQuestionsStats().wrongCount,
                passCount: getQuestionsStats().passCount,
                remainingTime: getRemainingTime()
            )
                .tag(0)
            AnswersView(questions: getQuestions())
                .tag(1)
        }
        .tabViewStyle(DefaultTabViewStyle())
        .overlay(alignment: .bottom){
            BottomBarView(tabSelection: $tabSelection)
                .padding(.bottom,4)
        }
        .onAppear{
            if saveQuestions {
                saveDailyGame()
            }
        }
    }
}

struct GetQuestionsStatsType{
    let correctCount:Int
    let wrongCount:Int
    let passCount:Int
}

extension GameSummaryView{
    func getRemainingTime() -> String{
        let time: String = savedDailyGame.isEmpty
            ? remainingTime
            : savedDailyGame[0].remainingTime
        return time
    }
    
    func getQuestions() -> [Question]{
        let questionArray: [Question] = savedDailyGame.isEmpty || savedDailyGame[0].dailyGameQuestions.isEmpty
            ? questions
            : savedDailyGame[0].dailyGameQuestions
        return questionArray
    }
    
    func getQuestionsStats() -> GetQuestionsStatsType{
        var correctCount = 0
        var wrongCount = 0
        var passCount = 0
        let questionArray: [Question] = getQuestions()
        questionArray.forEach({
            switch $0.answerState {
            case AnswerState.isCorrect:
                correctCount += 1
            case AnswerState.isWrong:
                wrongCount += 1
            case AnswerState.isPassed:
                passCount += 1
            case AnswerState.none:
                passCount += 1
            default:
                passCount += 1
            }
        })
        
        return GetQuestionsStatsType(correctCount: correctCount, wrongCount: wrongCount, passCount: passCount)
    }
    
    func saveDailyGame(){
        do{
            if savedDailyGame.isEmpty{
                let newDailyGame = DailyGame(date: .now, dailyGameQuestions: questions, remainingTime: remainingTime)
                modelContext.insert(newDailyGame)
            }
            else if let savedData = savedDailyGame.first, !Utils.isDateToday(savedData.date){
                modelContext.delete(savedData)
                let newDailyGame = DailyGame(date: .now, dailyGameQuestions: questions, remainingTime: remainingTime)
                modelContext.insert(newDailyGame)
            }
            try modelContext.save()
        }
        catch{
            
        }
    }
}

#Preview {
    NavigationStack{
        GameSummaryView(questions: fakeDataWithAnswer, remainingTime: "02.00")
    }
}
