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
    private lazy var customScene: CustomSceneController = CustomSceneController()
    
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
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        customScene.configureSceneView(view, true)
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
            make.top.left.right.height.equalToSuperview()
        }
    }
    
    func configuration(_ model: CharacterModel){
        let scene = customScene.set3DCharacter(model.file ?? "")
        nameText.text = model.name
        chracterBackgroundView.backgroundColor = model.color
        self.sceneCharacterView.scene = scene
    }
}


//MARK: - Override Class
class CustomSceneController: SceneCotroller{
    override func setupCamera(in scene: SCNScene) {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 27, z: 60)
        scene.rootNode.addChildNode(cameraNode)
    }
    
    override func setupObject(in scene: SCNScene){
        if let object = scene.rootNode.childNodes.first{
            object.scale = SCNVector3(x: 0.4, y: 0.4, z: 0.4)// 1.1 공통
            
            let jumpAnimation = CAKeyframeAnimation(keyPath: "position.y")
            jumpAnimation.values = [object.position.y, object.position.y+3, object.position.y]
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
}
