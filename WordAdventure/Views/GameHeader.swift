//
//  LetterCircle.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 1.12.2023.
//

import SwiftUI

struct GameHeader: View {
    let letter: String
    let letterSize: CGFloat
    let answerState: AnswerState
    let isFocused: Bool
    let onFinish: () -> Void
    var body: some View {
        let condition = isFocused && UIDevice.current.userInterfaceIdiom == .phone
        let circleSize = UIDevice.current.userInterfaceIdiom == .phone ? letterSize : 120
        let layout = condition ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())
        layout{
            Text(letter == "i" ? "İ" : letter.uppercased())
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
                TimerView(onFinish: onFinish)
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
    GameHeader(letter: "i", letterSize: 100,answerState: .none,isFocused: false, onFinish: {})
}
