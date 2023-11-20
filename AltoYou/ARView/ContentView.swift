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
    
    
    class Coordinator: NSObject {
        var subscriptions = Set<AnyCancellable>()
        var modelEntity: ModelEntity?
        
        @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
            guard let modelEntity = modelEntity else { return }
            
            
            let scale = gesture.scale
            modelEntity.scale *= Float(scale)
            gesture.scale = 1.0
        }
        
        @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
            guard let modelEntity = modelEntity else { return }
            
            if gesture.state == .changed {
                if gesture.numberOfTouches == 1{
                    let translation = gesture.translation(in: gesture.view)
                    let translationIn3D = SIMD3<Float>(Float(translation.x) * 0.001, 0.0, Float(translation.y) * 0.001)
                    modelEntity.position += translationIn3D
                    gesture.setTranslation(.zero, in: gesture.view)
                } else if gesture.numberOfTouches == 2{
                    let translation = gesture.translation(in: gesture.view)
                    gesture.setTranslation(CGPoint.zero, in: gesture.view)
                    
                    let axis : SIMD3<Float> = [0,1,0]
                    let rotationFactor: Float = 0.01
                    let rotaionAngle = Float(translation.x) * rotationFactor
                    
                    modelEntity.transform.rotation *= simd_quatf(angle: rotaionAngle, axis: axis)
                }
            }
        }
    }
    
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        let modelName = modelName
        
        let anchor = AnchorEntity(.plane(.horizontal, classification: .floor, minimumBounds: SIMD2<Float>(0.3, 0.3)))
        
        ModelEntity.loadModelAsync(named: modelName)
            .sink(receiveCompletion: { loadCompletion in
            }, receiveValue: { modelEntity in
                context.coordinator.modelEntity = modelEntity
                anchor.addChild(modelEntity)
                
                if let animation = modelEntity.availableAnimations.first {
                    modelEntity.playAnimation(animation.repeat())
                }
                
                /*
                 //모델 그림자 생성 막는 경향 있다.
                 let distance: Float = 1.2
                 modelEntity.position = [0, -1, -distance]
                 */
                
                let pinchGesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePinch(_:)))
                arView.addGestureRecognizer(pinchGesture)
                
                // Add Pan Gesture Recognizer for Moving
                let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePan(_:)))
                arView.addGestureRecognizer(panGesture)
                
            })
        
            .store(in: &context.coordinator.subscriptions)
        
        let light = DirectionalLight()
        light.light.intensity = 5000
        light.light.color = .white
        light.shadow = DirectionalLightComponent.Shadow(maximumDistance: 4,depthBias: 1)
        light.orientation = simd_quatf(angle: .pi / 4, axis: [0, 0, 0])
        light.position = [0, 10, 20]
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
