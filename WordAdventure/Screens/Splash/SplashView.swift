//
//  SplashView.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 30.11.2023.
//

import SwiftUI

struct SplashView: View {
    @State var iconSize: CGFloat = 0
    var body: some View {
        VStack{
           Image("icon")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: iconSize,height: iconSize)
              
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(.accent)
        .onAppear{
            withAnimation(.bouncy.speed(0.4)){
                iconSize = 250
            }
        }
    }
}

#Preview {
    SplashView()
}
