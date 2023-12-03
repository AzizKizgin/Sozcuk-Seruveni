//
//  GameInfo.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 3.12.2023.
//

import SwiftUI
struct GameInfo: View {
    let onClose: () -> Void
    var body: some View {
        ScrollView{
            VStack(spacing: 40){
                Text("Nasıl Oynanır?")
                    .bold()
                Text("""
                    Sözcük Serüveni, 27 harf, her harf için bir kelime ve bu kelimenin anlamını içerir.

                    Örneğin \(Text("A").bold()) harfi için sorulabilecek \(Text("\"\("Ağaçtan, tahtadan yapılmış")\"").bold()) sorusunun cevabı \(Text("\"\("Ahşap")\"").bold()) olacaktır.

                    Toplam süre \(Text("\"\("5 dakikadır")\"").bold()).

                    Bu süre içinde belirtilen alana cevabını yazmalı ya da \(Text("\"\("Pas")\"").bold()) butonuna basmalısın.

                    Süre bittiğinde oyun biter ve seni sonuç sayfasına yönlendirir. Oyunu erkenden bitirmek için \(Text("\"\("Bitir")\"").bold()) yazabilirsin.
                    """)
                HStack{
                    Button(action: onClose, label: {
                        Text("Kapat ve Başla")
                            .frame(maxWidth: .infinity)
                            .frame(height: 30)
                            .foregroundStyle(.white)
                    })
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity)
                }
            }
            .padding()
            .font(UIDevice.current.userInterfaceIdiom == .phone ? .title3: .title)
            .foregroundStyle(.accent)
        }
    }
}

#Preview {
    GameInfo(onClose: {})
}
