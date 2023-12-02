//
//  HomeButton.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 28.11.2023.
//

import SwiftUI

struct HomeButton: View {
    let title: String
    let onPress: () -> Void
    var icon: String = "\(Utils.getDay()).circle"
    var body: some View {
        Button(action: onPress, label: {
            HStack{
                Text(title)
                Spacer()
                Image(systemName: icon)
                    .font(.title)
            }
            .padding(12)
            .overlay{
                RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                    .stroke(style: .init(lineWidth: 3))
                    .foregroundStyle(.accent)
            }
        })
        .font(.title2)
        .foregroundStyle(.accent)
        .buttonStyle(HomeButtonStyle())
    }
}

struct HomeButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.7 : 1)
            .contentShape(Rectangle())
    }
}

#Preview {
    HomeButton(title: "Günlük", onPress: {})
}
