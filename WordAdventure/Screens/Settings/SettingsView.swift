//
//  SettingsView.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 10.12.2023.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(spacing:30){
            ThemeToggle()
            SoundToggle()
        }
        .padding()
        .navigationTitle("Ayarlar")
    }
}

#Preview {
    NavigationStack{
        SettingsView()
    }
}
