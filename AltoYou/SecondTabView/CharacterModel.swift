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
}

final class CharacterInfo {
    static let CharacterList : [CharacterModel] = [
        CharacterModel(name: "멍멍이", color: UIColor.white, voice: "Mongmongi"),
            CharacterModel(name: "찍찍이", color: UIColor.white, voice: "Jjijjigi"),
        CharacterModel(name: "흰둥이", color: UIColor.white, voice: "Hindung")
    ]
}
