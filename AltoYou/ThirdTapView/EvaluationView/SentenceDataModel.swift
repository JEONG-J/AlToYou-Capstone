//
//  SentenceData.swift
//  AltoYou
//
//  Created by 정의찬 on 11/26/23.
//


//NOTE: - Onission, Insertion, Mispronunciation, UnexpectedBreak, MissingBreak 및 Monotone

import Foundation
import UIKit

///MARK: - 유저 대화 오류
struct ErrorInfo {
    var errorWord: String
    var errorType: String
}

///MARK: - 유저 대화 내용
struct SentenceUserData {
    var sentence: String
    var errors: [ErrorInfo]
}

///MARK: - 모델 대화 내용
struct SentenceModelData {
    var sentence: String
}

struct InterleavedSetenceData {
    var userSentenceData: SentenceUserData?
    var modelSentenceData: SentenceModelData?
    var isUserSentence: Bool {
        return userSentenceData != nil
    }
    var sentence: String {
        return userSentenceData?.sentence ?? modelSentenceData?.sentence ?? ""
    }
    
    init(userSentenceData: SentenceUserData? = nil, modelSentenceData: SentenceModelData? = nil) {
        self.userSentenceData = userSentenceData
        self.modelSentenceData = modelSentenceData
    }
}

final class SentenceHistory {
    let conversationUserSentence = [
        SentenceUserData(sentence: "The quick brown fox jumps over the lazy dog", errors: [ErrorInfo(errorWord: "quick", errorType: "Onission")]),
        SentenceUserData(sentence: "good mornig??", errors: [ErrorInfo(errorWord: "morning?", errorType: "Monotone")]),
        SentenceUserData(sentence: "I am learning to code in Swift.", errors: [ErrorInfo(errorWord: "quick", errorType: "MissingBreak")]),
        SentenceUserData(sentence: "I am so happy", errors: [ErrorInfo(errorWord: "happy", errorType: "UnexpectedBreak")]),
        SentenceUserData(sentence: "what your name?", errors: [ErrorInfo(errorWord: "what", errorType: "Insertion")]),
        SentenceUserData(sentence: "I am so hungry", errors: [ErrorInfo(errorWord: "hungry", errorType: "Mispronunciation")])
    ]
    
    let conversationModelSentence = [
    SentenceModelData(sentence: "hello, what your name?"),
    SentenceModelData(sentence: "haha, my name is jake"),
    SentenceModelData(sentence: "student job problem"),
    SentenceModelData(sentence: "i am so luckky"),
    SentenceModelData(sentence: "so so so so so so"),
    ]
}


