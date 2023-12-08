//
//  SendButton.swift
//  AltoYou
//
//  Created by 정의찬 on 12/7/23.
//

import SwiftUI
import PopupView
struct SendButton: View {
    @ObservedObject var buttonViewModel: ButtonViewModel
    var voiceAPIHandler: VoiceAPIHandler?
    var chartAPI: ChartAPI?
    
    var body: some View {
        ZStack{
            Button(action: {
                chartAPI?.getChartInfo()
                chartAPI?.fetchDataHistory()
                voiceAPIHandler?.endVoice()
                buttonViewModel.showExitButton = true
                buttonViewModel.showingPopup = true
            }) {
                Image("send")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .padding()
            }
        }
    }
}
