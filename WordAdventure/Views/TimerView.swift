//
//  Timer.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 2.12.2023.
//

import SwiftUI

struct TimerView: View {
    @State private var elapsedTime: TimeInterval = 300
    @State private var isRunning = false
    private let timerInterval = 1.0
    let onFinish: () -> Void

    var body: some View {
        VStack {
            Text(formatElapsedTime())
                .font(.largeTitle)
                .padding()
                .onAppear{
                    startTimer()
                }
        }
    }

    private func startTimer() {
        isRunning = true
        Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { timer in
            if self.elapsedTime > 0 {
                self.elapsedTime -= 1
            }
            else{
                onFinish()
            }
        }
    }

    private func formatElapsedTime() -> String {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60

        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    TimerView(onFinish: {})
}
