//
//  DayModel.swift
//  AltoYou
//
//  Created by 정의찬 on 10/6/23.
//

import Foundation
import UIKit

public struct CharacterModel{
    let name: String?
    let color: UIColor?
    let voice: String?
    let file: String?
}

final class CharacterInfo {
    static let CharacterList : [CharacterModel] = [
        CharacterModel(name: "멍멍이", color: UIColor(red: 1.00, green: 0.85, blue: 0.75, alpha: 1.00), voice: "Mongmong-e", file: "Mongmong-e.usdz"),
        CharacterModel(name: "냥냥이", color: UIColor(red: 0.71, green: 0.81, blue: 0.71, alpha: 1.00), voice: "Yangyangi", file: "Yangyangi.usdz"),
        CharacterModel(name: "흰둥이", color: UIColor(red: 1.00, green: 0.88, blue: 0.91, alpha: 1.00), voice: "Hindung-e", file: "Hindung-e.usdz")
    ]
}
