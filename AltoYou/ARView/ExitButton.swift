//
//  ExitButton.swift
//  AltoYou
//
//  Created by 정의찬 on 11/13/23.
//

import SwiftUI

struct ExitButton: View {
    var body: some View{
        Button(action: {
            NotificationCenter.default.post(name: NSNotification.Name("CloseARView"), object: nil)
        }){
            Image("close")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
        }
    }
}
