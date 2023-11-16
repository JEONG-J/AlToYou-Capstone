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
    @State private var showARView = true
    @ObservedObject var voiceAPIHandler = VoiceAPIHandler()
    @EnvironmentObject var selectedCharacterInfo: SelectedCharacterInfo
    
    var selectedCharater: CharacterInfo?
    
    var body: some View {
        
        ZStack{
            if showARView, let character = selectedCharacterInfo.character {
                ARViewContainer(modelName: character.file ?? "").edgesIgnoringSafeArea(.all)
            }
            VStack{
                HStack{
                    ExitButton()
                        .padding()
                    Spacer()
                }
                Spacer()
            }
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    MICButton()
                        .padding()
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("CloseARView"))) { _ in
            self.showARView = false
        }
        .onAppear{
            voiceAPIHandler.beginVoice{ result in
                switch result {
                case .success(let response):
                    if let url = response.url {
                        playVoice(from: url)
                        print("success")
                    }
                case.failure(let error):
                    print("Error : \(error)")
                }
            }
        }
    }
    
    struct ARViewContainer: UIViewRepresentable {
        
        var modelName: String
        @EnvironmentObject var adudioManager: AudioManager
        @EnvironmentObject var voiceAPIHandler: VoiceAPIHandler
        
        func makeUIView(context: Context) -> ARView {
            
            AudioManager.shared.stopMusic()
            let arView = ARView(frame: .zero)
            
            loadModel(modelName: modelName, in: arView)
            
            return arView
            
        }
        
        func updateUIView(_ uiView: ARView, context: Context) {}
        
        private func loadModel(modelName: String, in arView: ARView){
            let fileName = modelName
            if (try? ModelEntity.loadModel(named: fileName)) != nil{
                if let modelEntity = try? ModelEntity.loadModel(named: fileName) {
                    
                    /*
                     //수평 평면
                     let anchorEntity = AnchorEntity(.plane(.horizontal, classification: <#T##AnchoringComponent.Target.Classification#>, minimumBounds: T##SIMD2<Float>))
                     */
                    let anchorEntity = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.6, 0.6)))
                    anchorEntity.addChild(modelEntity)
                    arView.scene.addAnchor(anchorEntity)
                }
            }
            
        }
        
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
        backgroundMusicPlayer?.pause()
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

