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
    
    private func makeAttributedString(from sentenceData: SentenceData) -> AttributedString {
        var attributedString = AttributedString(sentenceData.sentence)
        
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


/*
#Preview {
    SentencGridView()
}*/
