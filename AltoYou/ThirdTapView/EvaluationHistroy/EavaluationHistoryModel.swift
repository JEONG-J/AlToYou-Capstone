//
//  EavaluationModel.swift
//  AltoYou
//
//  Created by 정의찬 on 11/23/23.
//

import Foundation

//TODO: - 나중에 String값을 처리할 예정
struct EvaluationHistoryInfo: Codable {
    var estimationId: String
    var characterName: String
    var date: String
}

struct EvaluationHistory: Codable {
    var status: String
    var message: String
    var estimationList: [EvaluationHistoryInfo]
}
