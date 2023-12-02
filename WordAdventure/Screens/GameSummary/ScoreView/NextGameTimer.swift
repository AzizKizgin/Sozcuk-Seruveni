//
//  NextGameTimer.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 2.12.2023.
//

import SwiftUI

struct NextGameTimer: View {
    @State private var currentTime = Date()

    var body: some View {
        HStack {
            Text("Sonraki Oyun:")
                .font(.title2)
            Text(timeUntilMidnight())
                .font(.title)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                currentTime = Date()
            }
        }
    }

    func timeUntilMidnight() -> String {
        let calendar = Calendar.current
        let midnight = calendar.startOfDay(for: Date()).addingTimeInterval(24 * 60 * 60)
        let remainingTime = calendar.dateComponents([.hour, .minute, .second], from: currentTime, to: midnight)
        let formattedTime = String(format: "%02d:%02d:%02d", remainingTime.hour ?? 0, remainingTime.minute ?? 0, remainingTime.second ?? 0)
        return formattedTime
    }
}
#Preview {
    NextGameTimer()
}
