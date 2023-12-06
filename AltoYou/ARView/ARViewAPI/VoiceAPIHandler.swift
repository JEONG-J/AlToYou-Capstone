//
//  ServerCommunication.swift
//  AltoYou
//
//  Created by 정의찬 on 11/13/23.
//

import Foundation
import UIKit
import Alamofire

class VoiceAPIHandler: ObservableObject {

    @Published var responseBeginVoice: ResponseBeginVoice?
    @Published var requestSucceeded: Bool = false
    @Published var responseQnAVoice: GetVoice?
    
    func beginVoice(completion: @escaping (Result<ResponseBeginVoice, Error>) -> Void) {
        let url = "http://13.124.7.35:8080/api/conversation/start?userId=test&characterName=\(GlobalData.shared.characterName ?? "")"
        
        AF.request(url).responseDecodable(of: ResponseBeginVoice.self) { [weak self] response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let responseBeginVoice):
                    self?.responseBeginVoice = responseBeginVoice // 업데이트 방식 변경
                    if responseBeginVoice.status {
                        GlobalData.shared.conversationId = responseBeginVoice.conversationId
                        print("message: \(responseBeginVoice.message)")
                        print("URL : \(responseBeginVoice.url ?? "")")
                        print("conversatoinID: \(responseBeginVoice.conversationId)")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5){
                           playVoice(from: responseBeginVoice.url ?? "")
                        }
                    } else {
                        print("실패")
                    }
                case .failure(let error):
                    print("error: \(error)")
                }
            }
        }
    }
}
