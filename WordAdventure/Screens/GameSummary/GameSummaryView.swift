//
//  GameSummaryView.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 2.12.2023.
//

import SwiftUI

struct GameSummaryView: View {
    @State private var tabSelection = 0
    var body: some View {
        TabView(selection: $tabSelection){
            Text("1")
                .tag(0)
            Text("2")
                .tag(1)
        }
        .tabViewStyle(DefaultTabViewStyle())
        .overlay(alignment: .bottom){
            BottomBarView(tabSelection: $tabSelection)
                .padding(.bottom,4)
        }
    }
}

#Preview {
    NavigationStack{
        GameSummaryView()
    }
}
