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
    
    
    var body: some View {
        ZStack{
            Button(action: {
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
