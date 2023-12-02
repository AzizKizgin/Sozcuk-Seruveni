//
//  BottomBarView.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 2.12.2023.
//

import SwiftUI
struct BottomBarItem{
    let index: Int
    let title: String
    let icon: String
}

let barItems: [BottomBarItem] = [
    BottomBarItem(
        index: 0,
        title: "Sonuç",
        icon: "trophy"
    ),
    BottomBarItem(
        index: 1,
        title: "Cevaplar",
        icon: "character.book.closed"
    )
]

struct BottomBarView: View {
    @Binding var tabSelection: Int
    var body: some View {
        Capsule()
            .foregroundStyle(.accent)
            .frame(height: 60)
            .padding(.horizontal)
            .shadow(radius: 2.5)
            .overlay{
                HStack{
                    ForEach(barItems, id: \.index){ item in
                        Spacer()
                        VStack{
                            Image(systemName: item.index == tabSelection ? item.icon + ".fill": item.icon)
                            Text(item.title)
                                .bold(item.index == tabSelection)
                        }
                        .frame(maxWidth:.infinity)
                        .foregroundStyle(.white)
                        .onTapGesture {
                            tabSelection = item.index
                        }
                        Spacer()
                    }
                }
            }
    }
}

#Preview {
    BottomBarView(tabSelection: .constant(0))
}
