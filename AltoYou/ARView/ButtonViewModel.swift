//
//  ViewModel.swift
//  AltoYou
//
//  Created by 정의찬 on 12/7/23.
//

import Foundation
import SwiftUI

class ButtonViewModel: ObservableObject {
    @Published var showExitButton: Bool = false
    @Published var showingPopup: Bool = false
}
