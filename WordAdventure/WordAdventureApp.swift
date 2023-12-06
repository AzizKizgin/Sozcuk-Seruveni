//
//  WordAdventureApp.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 25.11.2023.
//

import SwiftUI
import FirebaseCore
import SwiftData

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct WordAdventureApp: App {
    let modelContainer : ModelContainer
    
    init() {
        do{
            modelContainer = try ModelContainer(for: Word.self,DailyGame.self, migrationPlan: nil)
        }
        catch{
            fatalError("failed when initialize model container")
        }
    }
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
        }
    }
}
