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
    @StateObject private var buttonViewModel = ButtonViewModel()
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
                Spacer()
                HStack{
                    Spacer()
                    if buttonViewModel.showExitButton == false {
                        SendButton(buttonViewModel: buttonViewModel)
                            .padding()
                    } else {
                        ExitButton(buttonViewModel: buttonViewModel)
                            .padding()
                    }
                }
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
        let treemodel = "Tree.usd"
        let bushmodel = "BushTwo.usdz"
        let stonemodel = "stone.usd"
        
        let treePosition = [
            SIMD3<Float>(-2.6,-4,-10),
            SIMD3<Float>(2.6,-4,-10),
            SIMD3<Float>(0,-4,-13),
            SIMD3<Float>(-1.6,-4,-13),
            SIMD3<Float>(1.6,-4,-13)
        ]
        
        let bushPositions = [
            SIMD3<Float>(2.6,-4,-10),
            SIMD3<Float>(1.6,-4,-8),
            SIMD3<Float>(0.6,-4,-7),
            SIMD3<Float>(-1.6,-4,-8),
            SIMD3<Float>(-2.6,-4,-10)
            ]
        
        let stonePosition = [
            SIMD3<Float>(-1.8,-4,-6),
            SIMD3<Float>(-1,-4,-6),
            SIMD3<Float>(-1.5,-4,-5)
        ]
        
        let anchor = AnchorEntity(.plane(.horizontal, classification: .floor, minimumBounds: SIMD2<Float>(0.3, 0.3)))
        
        // 동물 소환
        ModelEntity.loadModelAsync(named: modelName)
            .sink(receiveCompletion: { loadCompletion in
            }, receiveValue: { modelEntity in
                context.coordinator.modelEntity = modelEntity
                anchor.addChild(modelEntity)
                
                if let animation = modelEntity.availableAnimations.first {
                    modelEntity.playAnimation(animation.repeat())
                }
                
                let pinchGesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePinch(_:)))
                arView.addGestureRecognizer(pinchGesture)
                
                
                let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePan(_:)))
                arView.addGestureRecognizer(panGesture)
                
            })
        
            .store(in: &context.coordinator.subscriptions)
        
        for position in treePosition {
            let treeAnchor = AnchorEntity(world: position)
            ModelEntity.loadModelAsync(named: treemodel)
                .sink(receiveCompletion: {loadCompletion in
                }, receiveValue: { treemodel in
                    treemodel.position = SIMD3<Float>(0,0,0)
                    treemodel.scale = SIMD3<Float>(0.06,0.06,0.06)
                    treeAnchor.addChild(treemodel)
                })
                .store(in: &context.coordinator.subscriptions)
            arView.scene.addAnchor(treeAnchor)
        }
        
        for position in bushPositions {
            let bushAnchor = AnchorEntity(world: position)
            ModelEntity.loadModelAsync(named: bushmodel)
                .sink(receiveCompletion: {loadCompletion in
                }, receiveValue: { bushmodel in
                    bushmodel.position = SIMD3<Float>(0,0,0)
                    bushAnchor.addChild(bushmodel)
                })
                .store(in: &context.coordinator.subscriptions)
            arView.scene.addAnchor(bushAnchor)
        }
        
        for position in stonePosition {
            let stoneAnchor = AnchorEntity(world: position)
            ModelEntity.loadModelAsync(named: stonemodel)
                .sink(receiveCompletion: {loadCompletion in
                }, receiveValue: { stonemodel in
                    stonemodel.position = SIMD3<Float>(0,0,0)
                    stoneAnchor.addChild(stonemodel)
                })
                .store(in: &context.coordinator.subscriptions)
            arView.scene.addAnchor(stoneAnchor)
        }
        
        let light = DirectionalLight()
        light.light.intensity = 3500
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
