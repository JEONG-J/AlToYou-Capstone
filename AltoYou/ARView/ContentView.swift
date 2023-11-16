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
    
    @EnvironmentObject var selectedCharacterInfo: SelectedCharacterInfo
    var selectedCharater: CharacterInfo?
    
    var body: some View {
        ZStack{
            if let character = selectedCharacterInfo.character {
                ARViewContainer(modelName: character.file ?? "")
                    .edgesIgnoringSafeArea(.all)
            }
        }
        
    }
}

struct ARViewContainer: UIViewRepresentable {
    
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
        
        // Create horizontal plane anchor for the content
        let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
        
        // Load the model asynchronously
        ModelEntity.loadModelAsync(named: modelName)
            .sink(receiveCompletion: { loadCompletion in
                // Handle errors or completion
            }, receiveValue: { modelEntity in
                
                let scaleFactor: Float = 0.2  // Adjust this value as needed
                modelEntity.scale = SIMD3<Float>(scaleFactor, scaleFactor, scaleFactor)
                // Add the model to the anchor once it's loaded
                anchor.addChild(modelEntity)
                
                if let animation = modelEntity.availableAnimations.first {
                    modelEntity.playAnimation(animation.repeat())
                }
            })
            .store(in: &context.coordinator.subscriptions) // Assuming you have a way to store subscriptions in your coordinator
        
        // Add the horizontal plane anchor to the scene
        arView.scene.anchors.append(anchor)
        
        return arView
    }
    
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#Preview {
    ContentView()
}

