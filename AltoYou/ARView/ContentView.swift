//
//  ContentView.swift
//  Test3D
//
//  Created by 정의찬 on 11/16/23.
//

import SwiftUI
import RealityKit
import Combine

struct ContentView : View {
    @ObservedObject var voiceViewModel = VoiceViewModel()
    @EnvironmentObject var selectedCharacterInfo: SelectedCharacterInfo
    @State private var showARView = true
    var selectedCharater: CharacterInfo?
    
    var body: some View {
        ZStack{
            if  showARView, let character = selectedCharacterInfo.character {
                ARViewContainer(modelName: character.file ?? "")
                    .edgesIgnoringSafeArea(.all)
                    .onAppear(){
                        voiceViewModel.beginVoice()
                    }
                    .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("CloseARView"))) { _ in
                        self.showARView = false
                        AudioManager.shared.startMusic()
                    }
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
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    @EnvironmentObject var adudioManager: AudioManager
    var modelName: String
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    
    class Coordinator {
        var subscriptions = Set<AnyCancellable>()
    }
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        print(modelName)
        let modelName = modelName
        
        
        let anchor = AnchorEntity(.plane(.horizontal, classification: .floor, minimumBounds: SIMD2<Float>(0.3, 0.3)))
        
        
        ModelEntity.loadModelAsync(named: modelName)
            .sink(receiveCompletion: { loadCompletion in
            }, receiveValue: { modelEntity in
                
                anchor.addChild(modelEntity)
                
                if let animation = modelEntity.availableAnimations.first {
                    modelEntity.playAnimation(animation.repeat())
                }
                
                let distance: Float = 1.2
                modelEntity.position = [0, -1, -distance]
                
                
            })
            .store(in: &context.coordinator.subscriptions)
        
        let light = DirectionalLight()
        light.light.intensity = 3000
        light.light.color = .white
        light.shadow = DirectionalLightComponent.Shadow(maximumDistance: 3,depthBias: 1)
        light.orientation = simd_quatf(angle: .pi / 4, axis: [1, 2, 2])
        light.position = [0, 1, 3]
        anchor.addChild(light)
        
        arView.scene.anchors.append(anchor)
        
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
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
