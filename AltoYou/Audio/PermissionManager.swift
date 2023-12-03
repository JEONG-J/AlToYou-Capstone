//
//  PermissionManager.swift
//  AltoYou
//
//  Created by 정의찬 on 11/16/23.
//

import Foundation
import AVFoundation

class PermissionManager: ObservableObject {
    @Published var permissionGranted = false
    
    func requestAudioPermission(){
        AVCaptureDevice.requestAccess(for: .audio, completionHandler: { (granted: Bool) in
            if granted {
                print("Audio 권한 허용")
            } else {
                print("Audio 권한 거부")
            }
        })
    }
}
