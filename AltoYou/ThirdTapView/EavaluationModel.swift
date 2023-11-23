//
//  EavaluationModel.swift
//  AltoYou
//
//  Created by 정의찬 on 11/23/23.
//

import Foundation

//TODO: - 나중에 String값을 처리할 예정
struct EavaluationModel {
    var evaluationCharacter: String
    var evaluationDate: Date
}

final class EvaluationInfo {
    static let evaluationList: [EavaluationModel] = [
    EavaluationModel(evaluationCharacter: "Mongmong-e.png", evaluationDate: Date()),
    EavaluationModel(evaluationCharacter: "Hindung-e.png", evaluationDate: Date()),
    EavaluationModel(evaluationCharacter: "Mongmong-e.png", evaluationDate: Date()),
    EavaluationModel(evaluationCharacter: "Yangyangi.png", evaluationDate: Date()),
    EavaluationModel(evaluationCharacter: "Yangyangi.png", evaluationDate: Date()),
    EavaluationModel(evaluationCharacter: "Mongmong-e.png", evaluationDate: Date()),
    EavaluationModel(evaluationCharacter: "Hindung-e.png", evaluationDate: Date()),
    EavaluationModel(evaluationCharacter: "Hindung-e.png", evaluationDate: Date())
    ]
}
