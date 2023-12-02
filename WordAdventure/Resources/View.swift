//
//  View.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 30.11.2023.
//

import Foundation
import SwiftUI
extension View {
    func letterCircleStyle() -> some View {
        self.background(
            ZStack {
                Circle().fill(.white)
                Circle().strokeBorder(.accent, lineWidth: 1)
            }
        )
    }
}
