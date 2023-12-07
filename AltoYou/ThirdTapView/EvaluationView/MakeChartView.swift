//
//  MakeChartView.swift
//  AltoYou
//
//  Created by 정의찬 on 11/25/23.
//

import SwiftUI

struct MakeChartView: View {
    var labelData: String?
    var data: Double?
    var colors: Color
    var widthFrame: CGFloat = 145
    var heightFrame: CGFloat = 145
    
    var body: some View {
        VStack{
            Text("\(labelData ?? "")")
                .font(.custom("Goryeong-Strawberry", fixedSize: 30))
                .foregroundStyle(.black)
                .frame(width: 300)
            ZStack{
                Circle()
                    .trim(from: 0, to: 100)
                    .stroke(Color(red: 0.81, green: 0.83, blue: 0.85), lineWidth: 30)
                    .frame(width: self.widthFrame, height: self.heightFrame)
                Circle()
                    .trim(from: 0, to: CGFloat(data ?? 0) / 100)
                    .stroke(colors, style: StrokeStyle(lineWidth: 30, lineCap: .round))
                    .frame(width: self.widthFrame, height: self.heightFrame)
                Text("\(data ?? 0)")
                    .font(.custom("Goryeong-Strawberry", fixedSize: 30))
                    .foregroundStyle(.black)
            }
        }
    }
}

