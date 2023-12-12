//
//  SoundToggle.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 10.12.2023.
//

import SwiftUI

struct SoundToggle: View {
    @AppStorage("soundEnabled") var soundEnabled = true
    var body: some View {
        Toggle(isOn: $soundEnabled, label: {
            Text("Ses")
                .font(.title3)
        })
        .padding(12)
        .overlay{
            RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                .stroke(style: .init(lineWidth: 3))
                
        }
        .tint(.accent)
        .foregroundStyle(.accent)
    }
}

#Preview {
    SoundToggle()
}
