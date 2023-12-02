//
//  DailyGameView.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 30.11.2023.
//

import SwiftUI

struct DailyGameView: View {
    @StateObject var dailyGameViewModel = DailyGameViewModel()
    @Environment(\.dismiss) var dismiss
    @FocusState var isFocused
    @State var letterSize: CGFloat = 120
    var body: some View {
        VStack{
            Text(dailyGameViewModel.currentQuestion?.meaning ?? "")
                .frame(height: 250)
            HStack{
                TextField("Cevap", text: $dailyGameViewModel.answer)
                    .focused($isFocused)
                    .onSubmit {
                        dailyGameViewModel.checkAnswer()
                    }
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
                        letterSize: letterSize,
                        answerState: dailyGameViewModel.currentQuestion?.answerState ?? .none,
                        isFocused: isFocused,
                        onFinish: {dailyGameViewModel.showNoQuestionAlert.toggle()}
                    )
                }
            }
        }
        .onAppear{
            dailyGameViewModel.getQuestions{ error in
                if error != nil{
                    dailyGameViewModel.showNoQuestionAlert.toggle()
                }
            }
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
        .onChange(of: isFocused){ _, newFocus in
            withAnimation{
                if newFocus{
                    letterSize = 50
                }
                else{
                    letterSize = 120
                }
            }
        }
    }
}

#Preview {
    DailyGameView()
}
