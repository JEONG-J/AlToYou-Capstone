//
//  ChartView.swift
//  AltoYou
//
//  Created by 정의찬 on 11/29/23.
//

import SwiftUI

struct ChartView: View {
    var body: some View {
        ZStack(alignment: .center){
            Rectangle()
                .frame(width: 1100, height: 720)
                .foregroundStyle(Color(red: 0.98, green: 0.97, blue: 0.95).opacity(0.8))
                .clipShape(.rect(cornerRadius: 25))
                .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 10)
            
            VStack{
                Spacer(minLength: 40)
                HStack{
                    MakeChartView(data: evaluationPieChartData[0], colors: self.colorForLabel(evaluationPieChartData[0].label))
                    Spacer(minLength: 400)
                    MakeChartView(data: evaluationPieChartData[1], colors: self.colorForLabel(evaluationPieChartData[1].label))
                }
                HStack{
                    MakeChartView(data: evaluationPieChartData[2], colors: self.colorForLabel(evaluationPieChartData[2].label), widthFrame: 160, heightFrame: 160)
                }
                HStack{
                    MakeChartView(data: evaluationPieChartData[3], colors: self.colorForLabel(evaluationPieChartData[3].label))
                    Spacer(minLength: 400)
                    MakeChartView(data: evaluationPieChartData[4], colors: self.colorForLabel(evaluationPieChartData[4].label))
                }
                .padding(.bottom, 30)
            }
            .frame(width: 650, height: 500)
            
        }
    }
    private func colorForLabel(_ label: String) -> Color {
        switch label {
        case "평균 정확도": return Color(red: 1, green: 0.77, blue: 0.77)
        case "평균 유창성": return Color(red: 0.89, green: 0.56, blue: 0.27)
        case "평균 발음 완전성": return Color(red: 0.26, green: 0.49, blue: 0.62)
        case "평균 운율": return Color(red: 0.78, green: 0.86, blue: 0.65)
        case "평균 발음 품질": return  Color(red: 0.54, green: 0.73, blue: 0.68)
        default: return .gray
        }
    }
}

#Preview {
    ChartView()
}
