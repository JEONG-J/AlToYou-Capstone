//
//  MakeChartView.swift
//  AltoYou
//
//  Created by 정의찬 on 11/25/23.
//

import SwiftUI

struct MakeChartView: View {
    var data: ChartData
    var colors: Color
    
    var body: some View {
        ZStack{
            Circle()
                .trim(from: 0, to: CGFloat(data.value) / 100)
                .stroke(colors, lineWidth: 30)
                .frame(width: 150, height: 150)
            Text("\(Int(data.value))%")
                .font(.custom("Goryeong-Strawberry", fixedSize: 30))
        }
    }
}
