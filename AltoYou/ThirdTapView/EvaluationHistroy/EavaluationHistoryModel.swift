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
    var status: Bool
    var message: String
    var estimationList: [EvaluationHistoryInfo]
}

final class EvaluationInfo {
    let evaluationInfo: [EvaluationHistoryInfo] = [
    EvaluationHistoryInfo(estimationId: "1", characterName: "Mongmong-e", date: "23/11/22(수) 오전 01:33"),
    EvaluationHistoryInfo(estimationId: "2", characterName: "Yangyangi", date: "23/11/26(일) 오후 06:53"),
    EvaluationHistoryInfo(estimationId: "3", characterName: "Yangyangi", date: "23/12/3(일) 오후 10:01"),
    EvaluationHistoryInfo(estimationId: "4", characterName: "Mongmong-e", date: "23/12/4(월) 오후 11:04"),
    EvaluationHistoryInfo(estimationId: "5", characterName: "Hindung-e", date: "23/12/8(금) 오전 10:33"),
    EvaluationHistoryInfo(estimationId: "5", characterName: "Hindung-e", date: "23/12/8(금) 오후 10:33")
    ]
}
