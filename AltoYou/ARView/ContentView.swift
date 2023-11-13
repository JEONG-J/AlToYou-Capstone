//
//  ContentView.swift
//  AltoYou
//
//  Created by 정의찬 on 10/3/23.
//

import SwiftUI
import RealityKit
import AVFoundation
import Alamofire
import Combine

struct ContentView : View {
    
    let oiceAPIHandler = VoiceAPIHandler()
    
    var body: some View {
        ZStack{
            ARViewContainer().edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                MICButton()
                    .padding()
                    .padding(.trailing, 50)
            }
        }
    }
    
    struct ARViewContainer: UIViewRepresentable {
        
        @EnvironmentObject var adudioManager: AudioManager
        @EnvironmentObject var voiceAPIHandler: VoiceAPIHandler
        
        func makeUIView(context: Context) -> ARView {
            
            voiceAPIHandler.beginVoice { result in
                            switch result {
                            case .success(let responseBeginVoice):
                                if let url = URL(string: responseBeginVoice.url ?? "") {
                                    playVoice(from: url)
                                }
                            case .failure(let error):
                                // 오류 처리
                                print("Error fetching voice data: \(error)")
                            }
                        }

            
            AudioManager.shared.stopMusic()
            let arView = ARView(frame: .zero)
            
            // Create a cube model
            let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
            let material = SimpleMaterial(color: .gray, roughness: 0.15, isMetallic: true)
            let model = ModelEntity(mesh: mesh, materials: [material])
            
            // Create horizontal plane anchor for the content
            let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
            anchor.children.append(model)
            
            // Add the horizontal plane anchor to the scene
            arView.scene.anchors.append(anchor)
            
            return arView
            
        }
        
        func updateUIView(_ uiView: ARView, context: Context) {}
        
        static func dismantleUIView(_ uiView: ARView, coordinator: ()) {
            AudioManager.shared.startMusic()
        }
        
    }
}

class AudioManager: ObservableObject{
    static let shared = AudioManager()
    @Published private var isPlayMusic = false
    
    func startMusic(){
        AltoYou.startMusic("backgroundMusic")
        isPlayMusic = true
    }
    
    func stopMusic(){
        backgroundMusicPlayer?.stop()
        isPlayMusic = false
    }
    
    func toggleMusic(){
        if isPlayMusic{
            stopMusic()
        } else{
            startMusic()
        }
    }
}

