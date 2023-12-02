//
//  ContentView.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 25.11.2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("lastUpdate") var lastUpdate: String = ""
    @State var showSplash: Bool = true
    var body: some View {
        VStack{
            if showSplash{
                SplashView()
            }
            else{
                HomeView()
            }
        }
        .onAppear{
            Utils.getLastUpdateDate{ (date, error) in
                if let date = date{
                    if lastUpdate != date {
                        Utils.getAllWords{ (words, error) in
                            if let words{
                                words.forEach{word in
                                    modelContext.insert(word)
                                }
                                lastUpdate = date
                            }
                        }
                    }
                }
                else{
                    print("error")
                }
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
                withAnimation{
                    showSplash.toggle()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
