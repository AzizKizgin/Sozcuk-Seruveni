//
//  Timer.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 2.12.2023.
//

import SwiftUI

struct TimerView: View {
    @StateObject var stopWatchManager = StopWatchManager()
    let onFinish: () -> Void
    
    var body: some View {
        VStack {
            Text(stopWatchManager.formatElapsedTime())
                .foregroundStyle(.accent)
                .padding()
                .onAppear{
                    stopWatchManager.start()
                }
                .onChange(of: stopWatchManager.remainingTime){ oldValue, newValue in
                    if newValue == 0 {
                        stopWatchManager.stop()
                    }
            }
        }
    }
}

#Preview {
    TimerView(onFinish: {})
}

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
        remainingTime = 0
    }
    
    func formatElapsedTime() -> String {
        let minutes = Int(self.remainingTime) / 60
        let seconds = Int(self.remainingTime) % 60

        return String(format: "%02d:%02d", minutes, seconds)
    }
}
