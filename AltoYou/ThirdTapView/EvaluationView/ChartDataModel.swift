//
//  ChartDataModel.swift
//  AltoYou
//
//  Created by 정의찬 on 11/25/23.
//

import Foundation

struct ChartData: Codable {
//    var status: Bool
//    var message: String
//    var result: [Results]
//    var avgAccuracy: Double?
//    var avgFluency: Double?
//    var avgCompleteness: Double?
//    var avgPron: Double?
//    var avgProsody: Double?
        var result: [Results]
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
///
////
////  ChartDataModel.swift
////  AltoYou
////
////  Created by 정의찬 on 11/25/23.
////
//
//import Foundation
//
//struct ChartData: Codable {
//    var status: Int
//    var message: String? // 옵셔널 처리
//    var result: [Results]
//    var avgAccuracy: Double?
//    var avgFluency: Double?
//    var avgCompleteness: Double?
//    var avgPron: Double?
//    var avgProsody: Double?
//    
//    private enum CodingKeys: String, CodingKey {
//        case status
//        case message
//        case result?
//        case avgAccuracy
//        case avgFluency
//        case avgCompleteness
//        case avgPron
//        case avgProsody
//        // 만약 API 응답의 키가 다르다면 여기서 매핑
//        // 예: case message = "api_message_key"
//    }
//}
//
//struct Results: Codable, Hashable {
//    var modelSentence: String
//    var userSentence: String
//    var errors: [Errors]
//}
//
//struct Errors: Codable, Hashable {
//    var errorWord: String
//    var errorType: String
//}
//
