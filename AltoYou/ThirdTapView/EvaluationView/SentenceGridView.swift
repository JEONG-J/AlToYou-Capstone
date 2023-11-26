//
//  SentencGridView.swift
//  AltoYou
//
//  Created by 정의찬 on 11/26/23.
//

import SwiftUI

struct SentenceGridView: View {
    let SentenceDataModel = SentenceHistory()
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible())], spacing: 20) {
            ForEach(SentenceDataModel.conversationSentence, id: \.sentence) { data in
            sentenceView(for: data)
            }
        }
        .padding()
    }
    
    /// 문장속에 해당 단어만 커스텀 진행
    /// - Parameter sentenceData: 회화 진행하면서 응답한 회화
    /// - Returns: 에러 타입에 대한 문자 리턴
    private func makeAttributedString(from sentenceData: SentenceData) -> AttributedString {
        var attributedString = AttributedString(sentenceData.sentence)
        attributedString.font = .custom("Goryeong-Strawberry", size: 40)
        attributedString.foregroundColor = .black
        
        for error in sentenceData.errors {
            if let range = attributedString.range(of: error.errorWord) {
                attributedString[range].foregroundColor = .red
            }
        }
        return attributedString
    }
    
    private func sentenceView(for sentenceData: SentenceData) -> some View {
        Text(makeAttributedString(from: sentenceData))
    }
}



#Preview {
    SentenceGridView()
}
