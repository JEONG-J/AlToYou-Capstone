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

struct ContentView1 : View {
    @ObservedObject var voiceViewModel = VoiceViewModel()
    @State private var arView: ARView?
    @State private var showARView = true
    @EnvironmentObject var selectedCharacterInfo: SelectedCharacterInfo
    
    var selectedCharater: CharacterInfo?
    
    var body: some View {
        
        ZStack{
            if showARView, let character = selectedCharacterInfo.character {
                ARViewContainer(modelName: character.file ?? "", arView: $arView)
                    .environmentObject(AudioManager.shared) // AudioManager 인스턴스 주입
                    .edgesIgnoringSafeArea(.all)
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
            self.arView?.session.pause()
        }
        .onAppear{
            print("VoiceAPIHandler")
            voiceViewModel.beginVoice()
        }
    }
    
    struct ARViewContainer: UIViewRepresentable {
        
        var modelName: String
        @Binding var arView: ARView?
        @EnvironmentObject var adudioManager: AudioManager
        
        func makeUIView(context: Context) -> ARView {
            
            AudioManager.shared.stopMusic()
            let arView = ARView(frame: .zero)
            arView.isUserInteractionEnabled = true

            
            loadModel(modelName: modelName, in: arView)
            
            
            self.arView = arView
            
            return arView
            
        }
        
        func updateUIView(_ uiView: ARView, context: Context) {}
        
        private func loadModel(modelName: String, in arView: ARView) {
            let fileName = modelName
            if let modelEntity = try? ModelEntity.loadModel(named: fileName) {
                modelEntity.scale = SIMD3<Float>(0.1, 0.1, 0.1) // 크기를 더 작게 조정
                print(modelEntity.scale)
                
                let anchorEntity = AnchorEntity(.plane(.horizontal, classification: .floor , minimumBounds: SIMD2(0.1, 0.1)))
                anchorEntity.addChild(modelEntity)
                arView.scene.addAnchor(anchorEntity)

                // 모델의 스케일 조정
                modelEntity.availableAnimations.forEach { animation in
                    modelEntity.playAnimation(animation.repeat())
                }

            }
        }
        
        
        
        static func dismantleUIView(_ uiView: ARView, coordinator: Coordinator) {
            AudioManager.shared.startMusic()
        }
        
    }
}

class AudioMana2ger: ObservableObject{
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


