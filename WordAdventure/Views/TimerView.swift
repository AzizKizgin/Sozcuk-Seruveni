//
//  Timer.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 2.12.2023.
//

import SwiftUI

struct TimerView: View {
    let remainingTime: String
    var body: some View {
        VStack {
            Text(remainingTime)
                .foregroundStyle(.accent)
                .padding()
        }
    }
}

#Preview {
    TimerView(remainingTime: "02.33")
}


