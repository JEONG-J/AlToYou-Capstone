//
//  DataModel.swift
//  AltoYou
//
//  Created by 정의찬 on 11/13/23.
//

import Foundation
import UIKit

struct ResponseBeginVoice: Codable{
    let status : Bool
    let message: String
    let url : String?
}
