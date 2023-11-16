//
//  VoiceViewModel.swift
//  AltoYou
//
//  Created by 정의찬 on 11/16/23.
//

import Foundation
import SwiftUI

class VoiceViewModel: ObservableObject {
    @Published var voiceResponse: String?
    @ObservedObject var voiceAPIHandler = VoiceAPIHandler()

    func beginVoice() {
        voiceAPIHandler.beginVoice { result in
            print("heloooo---")
            DispatchQueue.main.async {
                print("heloooo---")
                switch result {
                case .success(let response):
                    self.voiceResponse = response.url
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}

