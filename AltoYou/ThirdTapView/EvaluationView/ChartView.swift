//
//  ChartView.swift
//  AltoYou
//
//  Created by 정의찬 on 11/29/23.
//

import SwiftUI

struct ChartView: View {
    let chartLabels = ["평균 정확도", "평균 유창성", "평균 발음 완전성", "평균 운율", "평균 발음 품질"]
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .frame(width: 1100, height: 720)
                .foregroundStyle(Color(red: 0.98, green: 0.97, blue: 0.95).opacity(0.8))
                .clipShape(.rect(cornerRadius: 25))
                .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 10)
            
            VStack {
                ForEach(chartLabels, id: \.self) { label in
                    HStack {
                        MakeChartView(labelData: label, data: chartDataForLabel(label), colors: colorForLabel(label))
                        Spacer(minLength: label == "평균 발음 완전성" ? 0 : 400) // 조건부 Spacer 추가
                    }
                }
            }
            .frame(width: 650, height: 500)
            .padding(.bottom, 30)
        }
    }

    private func chartDataForLabel(_ label: String) -> Double? {
        switch label {
        case "평균 정확도": return GlobalData.shared.chartData?.avgAccuracy
        case "평균 유창성": return GlobalData.shared.chartData?.avgFluency
        case "평균 발음 완전성": return GlobalData.shared.chartData?.avgCompleteness
        case "평균 운율": return GlobalData.shared.chartData?.avgPron
        case "평균 발음 품질": return GlobalData.shared.chartData?.avgProsody
        default: return nil
        }
    }

    private func colorForLabel(_ label: String) -> Color {
        let colorMap: [String: Color] = [
            "평균 정확도": Color(red: 1, green: 0.77, blue: 0.77),
            "평균 유창성": Color(red: 0.89, green: 0.56, blue: 0.27),
            "평균 발음 완전성": Color(red: 0.26, green: 0.49, blue: 0.62),
            "평균 운율": Color(red: 0.78, green: 0.86, blue: 0.65),
            "평균 발음 품질": Color(red: 0.54, green: 0.73, blue: 0.68)
            // 나머지 레이블에 대한 색상도 여기에 추가
        ]
        return colorMap[label, default: .gray]
    }
}


#Preview {
    ChartView()
}
