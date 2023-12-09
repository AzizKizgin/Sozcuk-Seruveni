//
//  HomeView.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 28.11.2023.
//

import SwiftUI

struct HomeView: View {
    @State var showDaily: Bool = false
    @State var showNormal: Bool = false
    @State var goSettings: Bool = false
    var body: some View {
        NavigationStack{
            VStack{
                VStack(spacing:30){
                    HomeButton(title: "Günlük", onPress: {
                        showDaily.toggle()
                    })
                    HomeButton(title: "Sınırsız", onPress: {
                        showNormal.toggle()
                    },icon:"infinity.circle")
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
            .navigationDestination(isPresented: $showDaily){
                GameView(gameMode: .daily)
            }
            .navigationDestination(isPresented: $showNormal){
                GameView(gameMode: .normal)
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {goSettings.toggle()}, label: {
                        Image(systemName: "gear")
                            .font(.title2)
                    })
                }
            }
            .navigationDestination(isPresented: $goSettings){
                SettingsView()
            }
        }
    }
}

#Preview {
    HomeView()
}
