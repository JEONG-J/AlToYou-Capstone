//
//  DataModel.swift
//  AltoYou
//
//  Created by 정의찬 on 11/13/23.
//

import Foundation
import UIKit

struct ResponseBeginVoice: Codable {
    var status: Bool
    var url: String?
    var message: String

    enum CodingKeys: String, CodingKey {
        case status, url, message
    }
/*
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let statusInt = try container.decode(Int.self, forKey: .status)
        status = statusInt != 0
        url = try container.decodeIfPresent(String.self, forKey: .url)
        message = try container.decode(String.self, forKey: .message)
    }
 */
}
