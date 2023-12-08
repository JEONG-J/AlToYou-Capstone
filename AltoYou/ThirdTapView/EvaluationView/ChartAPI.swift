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
        let url = "http://13.124.7.35:8080/api/estimation/\(GlobalData.shared.userId ?? "")/\(GlobalData.shared.conversationId ?? "")"
        
        AF.request(url).responseDecodable(of: ChartData.self) {response in
            switch response.result {
            case.success(let data):
                print("차트 데이터 주입 성공")
                GlobalData.shared.chartData = data
            case.failure(let error):
                print("겟 차트 error: \(error)")
            }
        }
    }
    
    func cellGetChartInfo(_ estimationId: String){
        let url = "http://13.124.7.35:8080/api/estimation/\(GlobalData.shared.userId ?? "")/\(estimationId)"
        AF.request(url).responseDecodable(of: ChartData.self) {response in
            switch response.result {
            case.success(let data):
                print("셀 클릭 차트 성공 : \(url)")
                GlobalData.shared.chartData = data
            case.failure(let error):
                print("셀 그래프 error: \(error)")
            }
        }
    }
    
    func fetchDataHistory(){
        let url = "http://13.124.7:8080/api/estimation/\(GlobalData.shared.userId ?? "")/estimations"
        
        AF.request(url).responseDecodable(of: EvaluationHistory.self) {response in
            switch response.result {
            case .success(let data):
                print("컬렉션 뷰 : 데이터 가져오기완료")
                GlobalData.shared.evaluationHistory = data
            case.failure(let error):
                print("error : \(error)")
            }
        }
    }
}
