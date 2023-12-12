//
//  SoundManager.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 10.12.2023.
//

import Foundation
import AVKit
import SwiftUI

class SoundManager{
    @AppStorage("soundEnabled") var soundEnabled = true
    static let shared = SoundManager()
    
    enum SoundType: String{
        case correct, pass, wrong
    }
    
    var player: AVAudioPlayer?
    
    func playSound(sound: SoundType){
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".wav") else{return}
        do{
            if soundEnabled{
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            }
        }
        catch let error{
            print("error when playing sound: \(error.localizedDescription)")
        }
    }
}
