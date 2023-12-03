//
//  StopWatchManager.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 3.12.2023.
//

import Foundation

class StopWatchManager: ObservableObject {
    
    @Published var remainingTime = 300
    var timer = Timer()
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.remainingTime -= 1
        }
    }
    
    func stop() {
        timer.invalidate()
    }
    
    func formatElapsedTime() -> String {
        let minutes = Int(self.remainingTime) / 60
        let seconds = Int(self.remainingTime) % 60

        return String(format: "%02d:%02d", minutes, seconds)
    }
}
