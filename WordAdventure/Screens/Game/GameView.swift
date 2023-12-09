//
//  DailyGameView.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 30.11.2023.
//

import SwiftUI
import SwiftData

struct GameView: View {
    let gameMode: GameMode
    @StateObject var gameViewModel = GameViewModel()
    @StateObject var stopWatchManager = StopWatchManager()
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @FocusState var isFocused
    @Query var savedDailyGame: [DailyGame]
    var body: some View {
        VStack{
            if gameViewModel.screen == .game {
                VStack{
                    Text(gameViewModel.currentQuestion?.meaning ?? "")
                        .font(UIDevice.current.userInterfaceIdiom == .phone ? .title2: .title)
                        .frame(height: 250)
                    HStack{
                        TextField("Cevap", text: $gameViewModel.answer)
                            .focused($isFocused)
                            .onSubmit {
                                gameViewModel.checkAnswer()
                            }
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        Button(action: gameViewModel.checkAnswer, label: {
                            gameViewModel.answer.isEmpty ? Text("Pas"): Text("Cevapla")
                        })
                        .buttonStyle(.borderedProminent)
                    }
                    .padding(10)
                    .background(Color.accent.opacity(0.1))
                    .cornerRadius(15)
                }
                .navigationBarBackButtonHidden(true)
                .toolbar{
                    ToolbarItem(placement: .topBarLeading){
                        Button {
                            gameViewModel.showCloseAlert.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "chevron.backward")
                                Text("Close")
                            }
                        }
                    }
                }
                .frame(maxHeight: .infinity)
                .padding()
                .overlay(alignment: .top){
                    VStack(spacing:10){
                        HStack{
                            GameHeader(
                                letter: gameViewModel.currentLetter,
                                answerState: gameViewModel.currentQuestion?.answerState ?? AnswerState.none,
                                remainingTime: stopWatchManager.formatElapsedTime(),
                                isFocused: isFocused
                            )
                            .onAppear{
                                stopWatchManager.start()
                            }
                            .onDisappear{
                                stopWatchManager.stop()
                            }
                            .onChange(of: stopWatchManager.remainingTime){ oldValue, newValue in
                                if newValue == 0 {
                                    stopWatchManager.stop()
                                    gameViewModel.showResultScreen()
                                }
                            }
                        }
                    }
                }
                .onAppear{
                    if gameMode == .daily{
                        //            gameViewModel.getQuestions{ error in
                        //                if error != nil{
                        //                    gameViewModel.showNoQuestionAlert.toggle()
                        //                }
                        //            }
                    }
                    gameViewModel.questions = fakeData
                }
                .alert("Sorular yüklenemedi", isPresented: $gameViewModel.showNoQuestionAlert){
                    Button("Tamam", role: .cancel) {
                        gameViewModel.showNoQuestionAlert.toggle()
                    }
                }
                .alert("Çıkmak istediğinden emin misin?", isPresented: $gameViewModel.showCloseAlert){
                    Button("Hayır", role: .cancel) {
                        gameViewModel.showCloseAlert.toggle()
                    }
                    Button("Evet", role: .destructive) {
                        dismiss()
                    }
                }
            }
            else if gameViewModel.screen == .info{
                GameInfo(onClose: gameViewModel.closeInfoScreen)
            }
            else{
                GameSummaryView(questions: getQuestionsForSummary(), remainingTime: getRemainingTimeForSummary())
                    .onAppear{
                        if gameMode == .daily{
                            saveDailyGame()
                        }
                    }
            }
        }
        .animation(.default, value: gameViewModel.screen)
        .onAppear{
            if let firstGame = savedDailyGame.first, !firstGame.dailyGameQuestions.isEmpty , gameMode == .daily , Utils.isDateToday(firstGame.date) {
                gameViewModel.screen = .result
            }
        }
    }
}

extension GameView{
    func getRemainingTimeForSummary() -> String{
        if gameMode == .daily && !savedDailyGame.isEmpty{
            return savedDailyGame[0].remainingTime
        }
        return stopWatchManager.formatElapsedTime()
    }
    
    func getQuestionsForSummary() -> [Question]{
        if gameMode == .daily && !savedDailyGame.isEmpty && !savedDailyGame[0].dailyGameQuestions.isEmpty {
            return savedDailyGame[0].dailyGameQuestions
        }
        return gameViewModel.questions
    }
    
    func saveDailyGame(){
        do{
            if savedDailyGame.isEmpty{
                let newDailyGame = DailyGame(date: .now, dailyGameQuestions: gameViewModel.questions, remainingTime: stopWatchManager.formatElapsedTime())
                modelContext.insert(newDailyGame)
            }
            else if let savedData = savedDailyGame.first, !Utils.isDateToday(savedData.date){
                modelContext.delete(savedData)
                let newDailyGame = DailyGame(date: .now, dailyGameQuestions: gameViewModel.questions, remainingTime: stopWatchManager.formatElapsedTime())
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
        GameView(gameMode: .daily)
    }
}
