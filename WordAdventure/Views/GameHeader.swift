//
//  LetterCircle.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 1.12.2023.
//

import SwiftUI

struct GameHeader: View {
    @AppStorage("soundEnabled") var soundEnabled = true
    let letter: String
    let answerState: Int
    let remainingTime: String
    let isFocused: Bool
    var body: some View {
        let condition = isFocused && UIDevice.current.userInterfaceIdiom == .phone
        let circleSize: CGFloat = UIDevice.current.userInterfaceIdiom == .phone && isFocused ? 50 : 120
        let layout = condition ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())
        layout{
            Text(letter.localizedUppercased())
                .font(.system(size: condition ? 25 : 55))
                .frame(width: circleSize,height: circleSize)
                .scaledToFit()
                .background(
                    ZStack {
                        Circle()
                            .fill(getCircleColor())
                        Circle()
                            .strokeBorder(.accent, lineWidth: 1)
                    }
                )
                .foregroundColor(answerState == AnswerState.none ? .accent : .white)
                Text(remainingTime)
                    .foregroundStyle(.accent)
                    .padding()
                    .font(condition ? .title: .largeTitle)
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .topTrailing){
            Button(action: {soundEnabled.toggle()}, label: {
                Image(systemName: "headphones.circle.fill")
                    .font(.largeTitle)
                    .padding()
                    .foregroundStyle(soundEnabled ? .green : .red)
            })
        }
        .animation(.default,value: condition)
    }
}

extension GameHeader{
    func getCircleColor() -> Color{
        switch answerState{
        case AnswerState.isCorrect:
            return .green
        case AnswerState.isPassed:
            return .yellow
        case AnswerState.isWrong:
            return .red
        case AnswerState.none:
            return .white
        default:
            return .white
        }
    }
}

#Preview {
    GameHeader(letter: "i", answerState: AnswerState.none, remainingTime: "02.33",isFocused: false)
}
