//
//  SentencGridView.swift
//  AltoYou
//
//  Created by 정의찬 on 11/26/23.
//

import SwiftUI

struct SentenceGridView: View {
    let sentenceDataModel = SentenceHistory()
    
    var body: some View {
        
            LazyVGrid(columns: [GridItem(.flexible())], spacing: 0) {
                ScrollView{
                ForEach(interleavedSentece, id: \.sentence) { sentence in
                    if sentence.isUserSentence {
                        sentenceUserView(for: sentence.userSentenceData!)
                    } else {
                        sentenceModelView(for: sentence.modelSentenceData!)
                    }
                }
            }
            .padding(.vertical, 20)
            .frame(width: 1200)
            .background(Color.white.opacity(0.8))
            .clipShape(.rect(cornerRadius: 25))
            .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 10)
            .padding()
        }
    }
    
    var interleavedSentece: [InterleavedSetenceData] {
        var combineSentence = [InterleavedSetenceData]()
        let maxLength = max(sentenceDataModel.conversationUserSentence.count, sentenceDataModel.conversationModelSentence.count)
        
        for index in 0..<maxLength {
            if index < sentenceDataModel.conversationUserSentence.count {
                combineSentence.append(InterleavedSetenceData(userSentenceData: sentenceDataModel.conversationUserSentence[index]))
            }
            if index < sentenceDataModel.conversationModelSentence.count {
                combineSentence.append(InterleavedSetenceData(modelSentenceData: sentenceDataModel.conversationModelSentence[index]))
            }
        }
        return combineSentence
    }
    
    ///MARK: - 유저 대화목록 폰트 처리
    private func makeUserAttributedString(from sentenceUserData: SentenceUserData) -> AttributedString {
        var attributedString = AttributedString("Me : \(sentenceUserData.sentence)")
        attributedString.font = .custom("Goryeong-Strawberry", size: 40)
        attributedString.foregroundColor = .black
        
        
        for error in sentenceUserData.errors {
            if let range = attributedString.range(of: error.errorWord) {
                attributedString[range].foregroundColor = .red
            }
        }
        return attributedString
    }
    
    ///MARK: - 모델 대화목록 폰트 처리
    private func makeModelAttributedString(from sentenceModelData: SentenceModelData) -> AttributedString {
        var attributedString = AttributedString("\(sentenceModelData.sentence) : You")
        attributedString.font = .custom("Goryeong-Strawberry", size: 40)
        attributedString.foregroundColor = .blue
        
        return attributedString
    }
    
    private func sentenceUserView(for sentenceUserData: SentenceUserData) -> some View {
        Text(makeUserAttributedString(from: sentenceUserData))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 25)
            .padding(.bottom, 5)
    }

    private func sentenceModelView(for sentenceModelData: SentenceModelData) -> some View {
        Text(makeModelAttributedString(from: sentenceModelData))
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 25)
            .padding(.bottom, 5)
    }
}



#Preview {
    SentenceGridView()
}
