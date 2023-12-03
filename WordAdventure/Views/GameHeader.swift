//
//  LetterCircle.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 1.12.2023.
//

import SwiftUI

struct GameHeader: View {
    let letter: String
    let answerState: AnswerState
    let remainingTime: String
    let isFocused: Bool
    var body: some View {
        let condition = isFocused && UIDevice.current.userInterfaceIdiom == .phone
        let circleSize: CGFloat = UIDevice.current.userInterfaceIdiom == .phone && isFocused ? 50 : 120
        let layout = condition ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())
        layout{
            Text(letter.uppercased(with: .init(identifier: "tr_TR")))
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
                .foregroundColor(answerState == .none ? .accent : .white)
                Text(remainingTime)
                    .foregroundStyle(.accent)
                    .padding()
                    .font(condition ? .title: .largeTitle)
        }
        .frame(maxWidth: .infinity)
        .animation(.default,value: condition)
    }
}

extension GameHeader{
    func getCircleColor() -> Color{
        switch answerState{
        case .isCorrect:
            return .green
        case .isPassed:
            return .yellow
        case .isWrong:
            return .red
        case .none:
            return .white
        }
    }
}

#Preview {
    GameHeader(letter: "i", answerState: .none, remainingTime: "02.33",isFocused: false)
}
