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
    
//http://13.124.7.35:8080/api
    
    func beginVoice(completion: @escaping (Result<ResponseBeginVoice, Error>) -> Void) {
        let url = "http://13.124.7.35:8080/api/conversation/start?userId=\(GlobalData.shared.userId ?? "")&characterName=\(GlobalData.shared.characterName ?? "")"
        
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
    
    func endVoice(){
        let url = "http://13.124.7.35:8080/api/conversation/end"
        
        let parameter = RequestEndVoice(userId: GlobalData.shared.userId ?? "", conversationId: GlobalData.shared.conversationId ?? "abc")
        let headers: HTTPHeaders = [
               "Content-Type": "application/json"
           ]
        
        AF.request(url, method: .post, parameters: parameter, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: ResponseEndVoice.self) {
            response in
            switch response.result {
            case.success(let data):
                print("전송 메시지 : \(data.message ?? "메시지 비워있음")")
                print(parameter)
            case.failure(let error):
                print("전송 실패 : \(error)")
            }
        }
    }
}

