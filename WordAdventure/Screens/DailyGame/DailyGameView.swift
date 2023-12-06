//
//  DailyGameView.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 30.11.2023.
//

import SwiftUI
import SwiftData

struct DailyGameView: View {
    @StateObject var dailyGameViewModel = DailyGameViewModel()
    @StateObject var stopWatchManager = StopWatchManager()
    @Environment(\.dismiss) var dismiss
    @FocusState var isFocused
    @Query var savedDailyGame: [DailyGame]
    var body: some View {
        VStack{
            if dailyGameViewModel.screen == .game {
                VStack{
                    Text(dailyGameViewModel.currentQuestion?.meaning ?? "")
                        .font(UIDevice.current.userInterfaceIdiom == .phone ? .title2: .title)
                        .frame(height: 250)
                    HStack{
                        TextField("Cevap", text: $dailyGameViewModel.answer)
                            .focused($isFocused)
                            .onSubmit {
                                dailyGameViewModel.checkAnswer()
                            }
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        Button(action: dailyGameViewModel.checkAnswer, label: {
                            dailyGameViewModel.answer.isEmpty ? Text("Pas"): Text("Cevapla")
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
                            dailyGameViewModel.showCloseAlert.toggle()
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
                                letter: dailyGameViewModel.currentLetter,
                                answerState: dailyGameViewModel.currentQuestion?.answerState ?? AnswerState.none,
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
                                    dailyGameViewModel.showResultScreen(time: stopWatchManager.formatElapsedTime())
                                }
                            }
                        }
                    }
                }
                .onAppear{
        //            dailyGameViewModel.getQuestions{ error in
        //                if error != nil{
        //                    dailyGameViewModel.showNoQuestionAlert.toggle()
        //                }
        //            }
                    dailyGameViewModel.questions = fakeData
                }
                .alert("Sorular yüklenemedi", isPresented: $dailyGameViewModel.showNoQuestionAlert){
                    Button("Tamam", role: .cancel) {
                        dailyGameViewModel.showNoQuestionAlert.toggle()
                    }
                }
                .alert("Çıkmak istediğinden emin misin?", isPresented: $dailyGameViewModel.showCloseAlert){
                    Button("Hayır", role: .cancel) {
                        dailyGameViewModel.showCloseAlert.toggle()
                    }
                    Button("Evet", role: .destructive) {
                        dismiss()
                    }
                }
            }
            else if dailyGameViewModel.screen == .info{
                GameInfo(onClose: dailyGameViewModel.closeInfoScreen)
            }
            else{
                GameSummaryView(questions: dailyGameViewModel.questions, remainingTime: stopWatchManager.formatElapsedTime(),saveQuestions:true)
            }
        }
        .animation(.default, value: dailyGameViewModel.screen)
        .onAppear{
            if let firstGame = savedDailyGame.first, !firstGame.dailyGameQuestions.isEmpty {
                dailyGameViewModel.screen = .result
            }
        }
    }
}

#Preview {
    NavigationStack{
        DailyGameView()
    }
}
