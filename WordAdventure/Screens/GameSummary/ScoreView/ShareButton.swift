//
//  ShareButton.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 2.12.2023.
//

import SwiftUI

struct ShareButton: View {
    let correctCount: Int
    let wrongCount: Int
    let passCount: Int
    let remainingTime: String

    var body: some View {
        ShareLink(item: getShareItem(),   preview: SharePreview("Sonucunu Paylaş")){
            Label("Sonucunu Paylaş", systemImage: "square.and.arrow.up")
                .foregroundStyle(.white)
                .padding(.horizontal)
        }
        .font(.system(size: 20))
        .foregroundStyle(.accent)
        .background{
            Capsule()
                .frame(height: 50)
        }
    }
}

extension ShareButton{
    private func getShareItem() -> String{
        return "Sözcük Serüveni\n\n🟢 \(correctCount) Doğru\n🔴 \(wrongCount) Yanlış\n🟡 \(passCount) Pass\n\n🕒 Kalan Süre \(remainingTime)\n"
    }
}

#Preview {
    ShareButton(correctCount: 10, wrongCount: 10, passCount: 10, remainingTime: "02.33")
}
