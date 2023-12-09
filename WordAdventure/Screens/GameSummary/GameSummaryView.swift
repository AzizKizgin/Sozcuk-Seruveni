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
    let questions: [Question]
    let remainingTime: String
    var body: some View {
        TabView(selection: $tabSelection){
            ScoreView(
                correctCount: getQuestionsStats().correctCount,
                wrongCount: getQuestionsStats().wrongCount,
                passCount: getQuestionsStats().passCount,
                remainingTime: remainingTime
            )
                .tag(0)
            AnswersView(questions: questions)
                .tag(1)
        }
        .tabViewStyle(DefaultTabViewStyle())
        .overlay(alignment: .bottom){
            BottomBarView(tabSelection: $tabSelection)
                .padding(.bottom,4)
        }
    }
}

struct GetQuestionsStatsType{
    let correctCount:Int
    let wrongCount:Int
    let passCount:Int
}

extension GameSummaryView{
    func getQuestionsStats() -> GetQuestionsStatsType{
        var correctCount = 0
        var wrongCount = 0
        var passCount = 0
        questions.forEach({
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
}

#Preview {
    NavigationStack{
        GameSummaryView(questions: fakeDataWithAnswer, remainingTime: "02.00")
    }
}
