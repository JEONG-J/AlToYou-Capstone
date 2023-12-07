//
//  ChartDataModel.swift
//  AltoYou
//
//  Created by 정의찬 on 11/25/23.
//

import Foundation

struct ChartData: Codable {
    var status: Bool
    var message: String
    var result: [Results]
    var avgAccuracy: Double?
    var avgFluency: Double?
    var avgCompleteness: Double?
    var avgPron: Double?
    var avgProsody: Double?
    
    var value: Double
    var label: String
}

struct Results: Codable, Hashable {
    var modelSentence: String
    var userSentence: String
    var errors: [Errors]
}

struct Errors: Codable, Hashable {
    var errorWord: String
    var errorType: String
}
