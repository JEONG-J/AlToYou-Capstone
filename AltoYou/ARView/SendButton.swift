//
//  SendButton.swift
//  AltoYou
//
//  Created by 정의찬 on 12/7/23.
//

import SwiftUI

struct SendButton: View {
    @ObservedObject var buttonViewModel: ButtonViewModel
    
    var body: some View {
        Button(action: {
            buttonViewModel.showExitButton = true
        }) {
            Image("send")
                .resizable()
                .frame(width: 150, height: 150)
                .padding()
        }
    }
}
