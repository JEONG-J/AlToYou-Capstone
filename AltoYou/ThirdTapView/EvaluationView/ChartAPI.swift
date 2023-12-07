//
//  ChartAPI.swift
//  AltoYou
//
//  Created by 정의찬 on 12/7/23.
//

import Foundation
import Alamofire

class ChartAPI {
    func getChartInfo(){
        let url = "http://13.124.7.35:8080/api//estimation/\(GlobalData.shared.userId ?? "")/\(GlobalData.shared.conversationId ?? "")"
        
        AF.request(url).responseDecodable(of: ChartData.self) {response in
            switch response.result {
            case.success(let data):
                GlobalData.shared.chartData = data
            case.failure(let error):
                print("error: \(error)")
            }
        }
    }
}
