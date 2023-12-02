//
//  ScoreView.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 2.12.2023.
//

import SwiftUI

struct ScoreView: View {
    let correctCount: Int
    let wrongCount: Int
    let passCount: Int
    let remainingTime: String
    var body: some View {
        VStack(spacing: 20){
            VStack(spacing: 10){
                ScoreItem(count: correctCount, type: .correct)
                ScoreItem(count: wrongCount, type: .wrong)
                ScoreItem(count: passCount, type: .passed)
            }
            NextGameTimer()
        }
    }
}

enum ScoreItemType{
    case correct, wrong, passed
}

struct ScoreItem: View {
    let count: Int
    let type: ScoreItemType
    var body: some View {
        HStack{
            HStack(spacing: 10){
                Image(systemName: "circle.fill")
                    .font(.title)
                    .foregroundStyle(getColor())
                Text("\(count)")
                    .bold()
                    .font(.title2)
                    .padding(.trailing, 30)
            }
            .frame(minWidth: 100,alignment: .leading)
            Text(getTitle())
                .font(.title3)
                .frame(width: 80,alignment: .leading)
        }
    }
    
    private func getTitle() -> String{
        switch type{
        case .correct:
            return "Doğru"
        case .wrong:
            return "Yanlış"
        case .passed:
            return "Pas"
        }
    }
    
    private func getColor() -> Color{
        switch type{
        case .correct:
            return .green
        case .wrong:
            return .red
        case .passed:
            return .yellow
        }
    }
}

struct NextGameTimer: View {
    @State private var currentTime = Date()

    var body: some View {
        HStack {
            Text("Sonraki Oyun:")
                .font(.title2)
            Text(timeUntilMidnight())
                .font(.title)
                .padding()
        }
        .onAppear {
            // Start the timer when the view appears
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                // Update the current time every second
                currentTime = Date()
            }
            ShareButton(title: "", content: "")
            NextGameTimer()
        }
    }

    // Function to calculate the time remaining until midnight
    func timeUntilMidnight() -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: currentTime)
        
        // Calculate the remaining time until midnight
        let midnight = calendar.startOfDay(for: Date()).addingTimeInterval(24 * 60 * 60)
        let remainingTime = calendar.dateComponents([.hour, .minute, .second], from: currentTime, to: midnight)
        
        // Format the remaining time as a string
        let formattedTime = String(format: "%02d:%02d:%02d", remainingTime.hour ?? 0, remainingTime.minute ?? 0, remainingTime.second ?? 0)
        
        return formattedTime
    }
}

#Preview {
    ScoreView(correctCount: 4, wrongCount: 1, passCount: 10, remainingTime: "01.43")
}
