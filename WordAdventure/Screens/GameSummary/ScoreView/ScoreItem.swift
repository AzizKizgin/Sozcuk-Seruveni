//
//  ScoreItem.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 2.12.2023.
//

import SwiftUI

enum ScoreItemType{
    case correct, wrong, passed
}

struct ScoreItem: View {
    let count: Int
    let type: ScoreItemType
    var body: some View {
        HStack{
            HStack(spacing: 10){
                Image(systemName: "circle.fill")
                    .font(.title)
                    .foregroundStyle(getColor())
                Text("\(count)")
                    .bold()
                    .font(.title2)
                    .padding(.trailing, 30)
            }
            .frame(minWidth: 100,alignment: .leading)
            Text(getTitle())
                .font(.title3)
                .frame(width: 80,alignment: .leading)
        }
    }
    
    private func getTitle() -> String{
        switch type{
        case .correct:
            return "Doğru"
        case .wrong:
            return "Yanlış"
        case .passed:
            return "Pas"
        }
    }
    
    private func getColor() -> Color{
        switch type{
        case .correct:
            return .green
        case .wrong:
            return .red
        case .passed:
            return .yellow
        }
    }
}

#Preview {
    ScoreItem(count: 10, type: .correct)
}
