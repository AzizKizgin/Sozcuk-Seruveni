//
//  ContentView.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 25.11.2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("lastUpdate") var lastUpdate: String = ""
    @AppStorage("isDarkTheme") var isDarkTheme = false
    @State var showSplash: Bool = true
    let auth = FirebaseManager.shared.auth
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
            auth.signInAnonymously()
            Utils.getLastUpdateDate{ (date, error) in
                if let date = date, lastUpdate.isEmpty{
                    do {
                        try modelContext.delete(model: Word.self)
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
                        try modelContext.save()
                    } catch {
                        lastUpdate = ""
                    }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
                withAnimation{
                    showSplash.toggle()
                }
            }
        }
        .preferredColorScheme(isDarkTheme ? .dark: .light)
    }
}

#Preview {
    MainActor.assumeIsolated{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Word.self,DailyGame.self, configurations: config)
        return
            NavigationStack{
                ContentView()
        }
        .modelContainer(container)
    }
}
