//
//  SentenceData.swift
//  AltoYou
//
//  Created by 정의찬 on 11/26/23.
//


//NOTE: - Onission, Insertion, Mispronunciation, UnexpectedBreak MissingBreak 및 Monotone

import Foundation
import UIKit

struct ErrorInfo {
    var errorWord: String
    var errorType: String
}

struct SentenceData {
    var sentence: String
    var errors: [ErrorInfo]
}

final class SentenceHistory {
    let conversationSentence = [
        SentenceData(sentence: "The quick brown fox jumps over the lazy dog", errors: [ErrorInfo(errorWord: "quick", errorType: "Onission")]),
        SentenceData(sentence: "good mornig??", errors: [ErrorInfo(errorWord: "morning?", errorType: "Monotone")]),
        SentenceData(sentence: "I am learning to code in Swift.", errors: [ErrorInfo(errorWord: "quick", errorType: "MissingBreak")]),
        SentenceData(sentence: "I am so happy", errors: [ErrorInfo(errorWord: "happy", errorType: "UnexpectedBreak")]),
        SentenceData(sentence: "what your name?", errors: [ErrorInfo(errorWord: "what", errorType: "Insertion")]),
        SentenceData(sentence: "I am so hungry", errors: [ErrorInfo(errorWord: "hungry", errorType: "Mispronunciation")])
    ]
}


