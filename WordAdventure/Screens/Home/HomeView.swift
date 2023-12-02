//
//  HomeView.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 28.11.2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack{
            VStack(spacing:30){
                HomeButton(title: "Günlük", onPress: {})
                HomeButton(title: "Sınırsız", onPress: {},icon:"infinity.circle")
            }
        }
        .frame(maxHeight: .infinity)
        .overlay(alignment: .top){
            Image("icon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120)
                .padding()
                .background(.accent)
                .clipShape(Circle())
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
