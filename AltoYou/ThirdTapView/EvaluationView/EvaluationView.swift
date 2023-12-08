//
//  EvaluationView.swift
//  AltoYou
//
//  Created by 정의찬 on 11/25/23.
//

import SwiftUI
import Alamofire

struct EvaluationView: View {
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Image("EvaluationView")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .ignoresSafeArea()
                ScrollView{
                    VStack{
                        Spacer(minLength: 16)
                        ZStack{
                            Rectangle()
                                .frame(width: 320, height: 70)
                                .foregroundStyle(Color(red: 1.00, green: 0.98, blue: 0.88))
                                .clipShape(.rect(cornerRadius: 40))
                            Text("대화 평가 차트")
                                .font(.custom("KaturiOTF", size: 50))
                                .foregroundStyle(Color(red: 0.98, green: 0.52, blue: 0.00))
                        }
                        Spacer(minLength: 15)
                        ChartView()
                            .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                        
                        Spacer(minLength: 200)
                        
                        ZStack{
                            Rectangle()
                                .frame(width: 320, height: 70)
                                .foregroundStyle(Color(red: 1.00, green: 0.98, blue: 0.88))
                                .clipShape(.rect(cornerRadius: 40))
                            Text("대화 문장 기록")
                                .font(.custom("KaturiOTF", size: 50))
                                .foregroundStyle(Color(red: 0.98, green: 0.52, blue: 0.00))
                        }
                        
                        SentenceGridView()
                    }
                }
                .ignoresSafeArea()
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .onAppear {
                getChartInfo()
            }
        }
   }
}

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



struct EvaluationView_Previews: PreviewProvider {
    static var previews: some View {
        EvaluationView()
    }
}
