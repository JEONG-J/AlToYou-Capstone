//
//  SceneController.swift
//  AltoYou
//
//  Created by 정의찬 on 11/15/23.
//

import Foundation
import UIKit
import SceneKit

class SceneCotroller {
    
    public func set3DCharacter(_ fileName: String) -> SCNScene{
        let scene = createScene(fileName: fileName)
        setupCamera(in: scene)
        setupObject(in: scene)
        lightScene(in: scene)
        ambientLightNode(in: scene)
        
        return scene
    }
    
    public func configureSceneView(_ sceneView: SCNView, _ interaction: Bool){
        sceneView.isUserInteractionEnabled = interaction
        sceneView.allowsCameraControl = true
        sceneView.backgroundColor = UIColor.clear
        sceneView.cameraControlConfiguration.allowsTranslation = false
    }
    
    private func createScene(fileName: String) -> SCNScene {
        return SCNScene(named: fileName) ?? SCNScene()
    }
    
    open func setupCamera(in scene: SCNScene){
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 12, z: 28) // 0 12 28
        scene.rootNode.addChildNode(cameraNode)
    }
    
    open func setupObject(in scene: SCNScene){
        if let object = scene.rootNode.childNodes.first{
            object.scale = SCNVector3(x: 1.1, y: 1.1, z: 1.1)// 1.1 공통
            
            let jumpAnimation = CAKeyframeAnimation(keyPath: "position.y")
            jumpAnimation.values = [object.position.y, object.position.y+2, object.position.y]
            jumpAnimation.keyTimes = [0, 0.5, 1]
            jumpAnimation.duration = 2
            
            let waitAnimation = CABasicAnimation(keyPath: "position.y")
            waitAnimation.fromValue = object.position.y
            waitAnimation.toValue = object.position.y
            waitAnimation.beginTime = 2
            waitAnimation.duration = 1
            
            let animationGroup = CAAnimationGroup()
            animationGroup.duration = 3
            animationGroup.animations = [jumpAnimation, waitAnimation]
            animationGroup.repeatCount = .infinity
            object.addAnimation(animationGroup, forKey: "jumpAndWaitAnimation")
            
            scene.rootNode.addChildNode(object)
        }
    }
    
    private func lightScene(in scene: SCNScene){
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .ambient
        lightNode.light?.intensity = 1500
        lightNode.position = SCNVector3(x: 0, y: 1, z: 20)
        scene.rootNode.addChildNode(lightNode)
    }
    
    private func ambientLightNode(in scene: SCNScene){
        let ambientLightNode = SCNNode()
        ambientLightNode.light? = SCNLight()
        ambientLightNode.light?.type = .area
        ambientLightNode.light?.color = UIColor.white
        scene.rootNode.addChildNode(ambientLightNode)
    }
}
