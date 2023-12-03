//
//  LetterView.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 30.11.2023.
//

import SwiftUI

struct LetterView: View {
    var letter: String
    
    var body: some View {
        Text(letter.uppercased(with: .init(identifier: "tr_TR")))
            .font(.system(size: 55))
            .frame(width: 120, height: 120)
            .letterCircleStyle()
            .foregroundColor(.accent)
            .padding(.horizontal, 8)
    }
}

#Preview {
    LetterView(letter: "a")
}
