//
//  LetterCircle.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 1.12.2023.
//

import SwiftUI

struct LetterCircle: View {
    let letter: String
    let letterSize: CGFloat
    let answerState: AnswerState
    let isFocused: Bool
    let onFinish: () -> Void
    var body: some View {
        HStack{
            Text(letter == "i" ? "İ" : letter.uppercased())
                .font(.system(size: letterSize == 120 ? 55 : 25))
                .frame(width: letterSize,height: letterSize)
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
        
            if isFocused{
                TimerView(onFinish: onFinish)
                    .font(.title)
            }
        }
    }
}

extension LetterCircle{
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
    LetterCircle(letter: "i", letterSize: 100,answerState: .none,isFocused: false, onFinish: {})
}
