//
//  SentencGridView.swift
//  AltoYou
//
//  Created by 정의찬 on 11/26/23.
//

import SwiftUI

struct SentenceGridView: View {
    // ChartData의 인스턴스 (예: GlobalData.shared.chartData)
    var chartData = GlobalData.shared.chartData
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
                    if let chartData = chartData {
                        ForEach(chartData.result, id: \.self) { result in
                            sentenceUserView(for: result.userSentence, errors: result.errors)
                                .padding()
                            sentenceModelView(for: result.modelSentence)
                                .padding()
                        }
                    }
                }
                .padding(.vertical, 15)
                .background(Color.white.opacity(0.8))
                .clipShape(.rect(cornerRadius: 25))
                .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 10)
                .padding()
            }
        }
    }
    
    private func makeAttributedString(for sentence: String, errors: [Errors]) -> AttributedString {
        var attributedString = AttributedString(sentence)
        attributedString.font = .custom("Goryeong-Strawberry", size: 40)
        
        for error in errors {
            if let range = attributedString.range(of: error.errorWord) {
                attributedString[range].foregroundColor = .red // 오류 단어에 대한 색상 변경
            }
        }
        return attributedString
    }
    
    private func sentenceUserView(for sentence: String, errors: [Errors]) -> some View {
        Text(makeAttributedString(for: "Me : \(sentence)", errors: errors))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 25)
            .padding(.bottom, 5)
    }
    
    private func sentenceModelView(for sentence: String) -> some View {
        Text("\(sentence) : You")
            .font(.custom("Goryeong-Strawberry", size: 40))
            .foregroundColor(.blue)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 25)
            .padding(.bottom, 5)
    }
}




#Preview {
    SentenceGridView()
}
