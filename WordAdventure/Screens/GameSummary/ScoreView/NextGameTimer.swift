//
//  NextGameTimer.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 2.12.2023.
//

import SwiftUI

struct NextGameTimer: View {
    @StateObject var nextGameTimerManager = NextGameTimerManager()

    var body: some View {
        HStack {
            Text("Sonraki Oyun:")
                .font(.title2)
            Text(nextGameTimerManager.timeUntilMidnight())
                .font(.title)
        }
        .onAppear {
            nextGameTimerManager.start()
        }
        .onDisappear{
            nextGameTimerManager.stop()
        }
    }


}
#Preview {
    NextGameTimer()
}

class NextGameTimerManager: ObservableObject {
    @Published private var currentTime = Date()
    var timer = Timer()
    
    func start(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.currentTime = Date()
        }
    }
    
    func stop(){
        timer.invalidate()
    }
    
    func timeUntilMidnight() -> String {
        let calendar = Calendar.current
        let midnight = calendar.startOfDay(for: Date()).addingTimeInterval(24 * 60 * 60)
        let remainingTime = calendar.dateComponents([.hour, .minute, .second], from: currentTime, to: midnight)
        let formattedTime = String(format: "%02d:%02d:%02d", remainingTime.hour ?? 0, remainingTime.minute ?? 0, remainingTime.second ?? 0)
        return formattedTime
    }
}
