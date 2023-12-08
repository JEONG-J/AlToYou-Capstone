//
//  File.swift
//  AltoYou
//
//  Created by 정의찬 on 11/15/23.
//

import Foundation
import UIKit

class GlobalData{
    static let shared = GlobalData()
    var userNickname: String?
    var characterName: String?
    var conversationId: String?
    var userId: String?
    var chartData: ChartData?
    var evaluationHistory: EvaluationHistory?
    
    init() {
           chartData = generateRandomData()
       }

       private func generateRandomData() -> ChartData {
           // Sample sentences
           let sentences = ["Hello, how are you?", "I'm fine, thank you!", "What's your plan for today?", "I'm planning to go shopping."]

           // Sample errors
           let errorWords = ["Hello", "fine", "plan", "shopping"]

           // Generate random results
           var results = [Results]()
           for _ in 0..<5 { // Generate 5 random results
               let randomSentenceIndex = Int.random(in: 0..<sentences.count)
               let randomErrorIndex = Int.random(in: 0..<errorWords.count)
               let result = Results(
                   modelSentence: sentences[randomSentenceIndex],
                   userSentence: sentences[(randomSentenceIndex + 1) % sentences.count],
                   errors: [Errors(errorWord: errorWords[randomErrorIndex], errorType: "Spelling")]
               )
               results.append(result)
           }
           return ChartData(result: results)
       }
}

