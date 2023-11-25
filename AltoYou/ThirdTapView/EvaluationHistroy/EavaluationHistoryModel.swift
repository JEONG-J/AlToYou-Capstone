//
//  EavaluationModel.swift
//  AltoYou
//
//  Created by 정의찬 on 11/23/23.
//

import Foundation

//TODO: - 나중에 String값을 처리할 예정
struct EavaluationHistoryModel {
    var evaluationCharacter: String
    var evaluationDate: Date
}

final class EvaluationHistroyInfo {
    static let evaluationHistoryList: [EavaluationHistoryModel] = [
    EavaluationHistoryModel(evaluationCharacter: "Mongmong-e.png", evaluationDate: Date()),
    EavaluationHistoryModel(evaluationCharacter: "Hindung-e.png", evaluationDate: Date()),
    EavaluationHistoryModel(evaluationCharacter: "Mongmong-e.png", evaluationDate: Date()),
    EavaluationHistoryModel(evaluationCharacter: "Yangyangi.png", evaluationDate: Date()),
    EavaluationHistoryModel(evaluationCharacter: "Yangyangi.png", evaluationDate: Date()),
    EavaluationHistoryModel(evaluationCharacter: "Mongmong-e.png", evaluationDate: Date()),
    EavaluationHistoryModel(evaluationCharacter: "Hindung-e.png", evaluationDate: Date()),
    EavaluationHistoryModel(evaluationCharacter: "Hindung-e.png", evaluationDate: Date())
    ]
}
