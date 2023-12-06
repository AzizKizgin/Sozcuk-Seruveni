//
//  String.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 5.12.2023.
//

import Foundation

extension String{
    func localizedLowercased() -> String{
        return self.lowercased(with: .init(identifier: "tr_TR"))
    }
    
    func localizedUppercased() -> String{
        return self.uppercased(with: .init(identifier: "tr_TR"))
    }
}
