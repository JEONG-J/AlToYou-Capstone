//
//  EvaluationView.swift
//  AltoYou
//
//  Created by 정의찬 on 11/25/23.
//

import SwiftUI

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
                        Spacer(minLength: 50)
                        ZStack(alignment: .center){
                            Rectangle()
                                .frame(width: 910, height: 750)
                                .foregroundStyle(.white.opacity(0.8))
                                .clipShape(.rect(cornerRadius: 25))
                                .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 10)
                            
                            VStack{
                                Spacer(minLength: 20)
                                HStack{
                                    MakeChartView(data: evaluationPieChartData[0], colors: self.colorForLabel(evaluationPieChartData[0].label))
                                    Spacer(minLength: 300)
                                    MakeChartView(data: evaluationPieChartData[1], colors: self.colorForLabel(evaluationPieChartData[1].label))
                                }
                                HStack{
                                    MakeChartView(data: evaluationPieChartData[2], colors: self.colorForLabel(evaluationPieChartData[2].label))
                                }
                                HStack{
                                    MakeChartView(data: evaluationPieChartData[3], colors: self.colorForLabel(evaluationPieChartData[3].label))
                                    Spacer()
                                    MakeChartView(data: evaluationPieChartData[4], colors: self.colorForLabel(evaluationPieChartData[4].label))
                                }
                            }
                            .frame(width: 650, height: 500)
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        SentenceGridView()
                    }
                }
                .ignoresSafeArea()
            }
        }
    }
    
    private func colorForLabel(_ label: String) -> Color {
        switch label {
        case "평균 정확도": return Color(red: 1, green: 0.77, blue: 0.77)
        case "평균 유창성": return Color(red: 1, green: 0.92, blue: 0.85)
        case "평균 발음 완전성": return Color(red: 0.26, green: 0.49, blue: 0.62)
        case "평균 운율": return Color(red: 0.78, green: 0.86, blue: 0.65)
        case "평균 발음 품질": return  Color(red: 0.54, green: 0.73, blue: 0.68)
        default: return .gray
        }
    }
}



struct EvaluationView_Previews: PreviewProvider {
    static var previews: some View {
        EvaluationView()
    }
}
