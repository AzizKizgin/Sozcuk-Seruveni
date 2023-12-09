//
//  ScoreView.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 2.12.2023.
//

import SwiftUI

struct ScoreView: View {
    let correctCount: Int
    let wrongCount: Int
    let passCount: Int
    let remainingTime: String
    let gameMode: GameMode
    var body: some View {
        VStack(spacing: 50){
            VStack(spacing: 10){
                ScoreItem(count: correctCount, type: .correct)
                ScoreItem(count: wrongCount, type: .wrong)
                ScoreItem(count: passCount, type: .passed)
                HStack{
                    Text("Kalan Zaman:")
                        .font(.title3)
                    Text(remainingTime)
                        .font(.title2)
                }
                .padding()
            }
            ShareButton(correctCount: 10, wrongCount: 10, passCount: 10, remainingTime: "01.33", gameMode: gameMode)
            if gameMode == .daily {
                NextGameTimer()
            }
        }
        .foregroundStyle(.accent)
    }
}

#Preview {
    ScoreView(correctCount: 4, wrongCount: 1, passCount: 10, remainingTime: "01.43", gameMode: .normal)
}


