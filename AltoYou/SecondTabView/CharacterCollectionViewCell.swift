//
//  CharacterCollectionViewCell.swift
//  AltoYou
//
//  Created by 정의찬 on 11/3/23.
//

import UIKit
import SnapKit
import SceneKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CharacterCollectionViewCell"
    
    ///MARK: - 캐릭터 이름 프로퍼티
    private lazy var nameText: UILabel = {
        let text = UILabel()
        text.text = "흰둥이"
        text.textColor = UIColor.black
        text.font = UIFont(name: "Goryeong-Strawberry", size: 35)
        return text
    }()
    
    
    ///MAAR: - 3D 캐릭터 추가하기
    private lazy var sceneCharacterView: SCNView = {
        let view = SCNView()
        configureSceneView(view)
        return view
    }()
    
    ///MARK: - 캐릭터 배경 프로퍼티
    lazy var chracterBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.shadowColor = UIColor(red: 0.071, green: 0.068, blue: 0.068, alpha: 0.25).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 2, height: 4)
        view.layer.masksToBounds = false
        
        return view
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeContraints()
        prepareForReuse()
    }
    
    required init?(coder : NSCoder){
        fatalError("error")
    }
    
    //MARK: - Function
    private func addView(){
        self.addSubview(nameText)
        self.addSubview(chracterBackgroundView)
        self.chracterBackgroundView.addSubview(sceneCharacterView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameText.text = nil
    }
    
    private func makeContraints(){
        addView()
        
        chracterBackgroundView.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.greaterThanOrEqualTo(269)
        }
        
        nameText.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(chracterBackgroundView.snp.bottom).offset(12)
        }
        
        sceneCharacterView.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func configuration(_ model: CharacterModel){
        nameText.text = model.name
        chracterBackgroundView.backgroundColor = model.color
        set3DCharacter(model.file ?? "")
    }
    
    //MARK: 3D Function
    private func set3DCharacter(_ fileName: String){
        let scene = createScene(fileName: fileName)
        setupCamera(in: scene)
        setupObject(in: scene)
        lightScene(in: scene)
        ambientLightNode(in: scene)
        sceneCharacterView.scene = scene
    }
    
    
    ///MARK: - 3D 캐릭터 초기화
    private func configureSceneView(_ sceneView: SCNView){
        sceneView.isUserInteractionEnabled = true
        sceneView.allowsCameraControl = true
        sceneView.backgroundColor = UIColor.clear
        sceneView.cameraControlConfiguration.allowsTranslation = false
    }
    
    private func createScene(fileName: String) -> SCNScene {
        return SCNScene(named: fileName) ?? SCNScene()
    }
    
    private func setupCamera(in scene: SCNScene){
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 12, z: 28)
        scene.rootNode.addChildNode(cameraNode)
    }
    
    private func setupObject(in scene: SCNScene){
        if let object = scene.rootNode.childNodes.first{
            object.scale = SCNVector3(x: 1.0, y: 1.0, z: 1.0)
            
            let waitAnimation = CABasicAnimation(keyPath: "position.y")
            waitAnimation.fromValue = object.position.y
            waitAnimation.toValue = object.position.y
            waitAnimation.beginTime = 2
            waitAnimation.duration = 1
            
            let animationGroup = CAAnimationGroup()
            animationGroup.duration = 3
            animationGroup.animations = [waitAnimation]
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
        lightNode.position = SCNVector3(x: 1, y: 1, z: 20)
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
