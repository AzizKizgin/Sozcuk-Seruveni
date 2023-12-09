//
//  ThemeToggleView.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 10.12.2023.
//

import SwiftUI

struct ThemeToggle: View {
    @AppStorage("isDarkTheme") var isDarkTheme = false
    var body: some View {
        Toggle(isOn: $isDarkTheme, label: {
            Text("Karanlık Mod")
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
    ThemeToggle()
}
