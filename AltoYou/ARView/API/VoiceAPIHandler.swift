//
//  ServerCommunication.swift
//  AltoYou
//
//  Created by 정의찬 on 11/13/23.
//

import Foundation
import UIKit
import Alamofire

class VoiceAPIHandler: ObservableObject{
    
    @Published var responseBeginVoice: ResponseBeginVoice?
    @Published var requestSucceeded: Bool = false
    
    
    //
    func beginVoice(completion: @escaping (Result<ResponseBeginVoice, Error>) -> Void){
        let url = "https://storage.googleapis.com/download/storage/v1/b/rtou/o/userId%2Fmodel%2FModelVoice2qaystHFPo.wav?generation=1699034302637668&alt=media"
        
        AF.request(url).responseDecodable(of: ResponseBeginVoice.self){ [weak self] response in
            
            DispatchQueue.main.async{
                switch response.result{
                case.success(let responseBeginVoice):
                    if responseBeginVoice.status{
                        self?.responseBeginVoice?.url = responseBeginVoice.url
                        self?.responseBeginVoice?.status = true
                        print("message: \(responseBeginVoice.message)")
                    } else {
                        self?.responseBeginVoice?.status = false
                        print("실패")
                    }
                case .failure(let error):
                    self?.responseBeginVoice?.status = false
                    print("error: \(error)")
                }
            }
        }
    }
    
    
    
}
