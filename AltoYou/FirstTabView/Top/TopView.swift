//
//  TopView.swift
//  AltoYou
//
//  Created by 정의찬 on 10/6/23.
//

// KaturiOTF
// Goryeong-Strawberry

import UIKit
import SnapKit
import SceneKit
import Lottie

class TopView: UIView {
    
    ///MARK: - 3D 이미지 뷰
    private lazy var sceneView: SCNView = {
        let sceneView = SCNView()
        let scene = SCNScene(named: "toy_biplane_idle.usdz")
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 12, z: 28)
        scene?.rootNode.addChildNode(cameraNode)
        
        if let object = scene?.rootNode.childNodes.first{
            object.scale = SCNVector3(x: 1.1, y: 1.1, z: 1.1)
            
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
        }
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .ambient
        lightNode.light?.intensity = 1500
        lightNode.position = SCNVector3(x: 0, y: 1, z: 20)
        scene?.rootNode.addChildNode(lightNode)
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .area
        ambientLightNode.light?.color = UIColor.white
        scene?.rootNode.addChildNode(ambientLightNode)
        
        sceneView.allowsCameraControl = true
        sceneView.backgroundColor = UIColor.clear
        sceneView.layer.cornerRadius = 50
        sceneView.clipsToBounds = true
        sceneView.cameraControlConfiguration.allowsTranslation = false
        sceneView.scene = scene
        
        return sceneView
    }()
    
    ///MARK: - 로그아웃 이미지
    private lazy var logoutBtn: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "door.png")
        btn.setImage(img, for: .normal)
        btn.addTarget(self, action: #selector(clickedBtn), for: .touchUpInside)
        return btn
    }()
    
    ///MARK: - 로그아웃 뷰
    private lazy var logoutView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.075, green: 0.075, blue: 0.196, alpha: 0.62).withAlphaComponent(0.62)
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        return view
    }()
    
    //MARK: - init
    required init?(coder: NSCoder){
        fatalError("error")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSelf()
        makeConstraints()
        logoutMakeConstraints()
    }
    //MARK: - Function
    
    ///MARK: - self 설정
    private func setSelf(){
        self.backgroundColor = .clear
        self.layer.cornerRadius = 20
        self.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        self.layer.masksToBounds = true
        self.isUserInteractionEnabled = true
    }
    
    ///MARK: - 뷰 추가
    private func addItem(){
        self.addSubview(sceneView)
        self.bringSubviewToFront(sceneView)
        self.addSubview(logoutView)
        self.bringSubviewToFront(logoutView)
    }
    
    ///MARK: - 오토레이아웃 함수
    private func makeConstraints(){
        addItem()
        
        sceneView.snp.makeConstraints{ (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(452)
            make.width.lessThanOrEqualTo(413)
            make.height.lessThanOrEqualTo(380)
        }
        
        logoutView.snp.makeConstraints{ (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-22)
            make.bottom.equalToSuperview().offset(-264)
            make.width.lessThanOrEqualTo(124)
            make.height.lessThanOrEqualTo(135)
        }
    }
    
    private func logoutMakeConstraints(){
        logoutView.addSubview(logoutBtn)
        
        logoutBtn.snp.makeConstraints{ (make) in
            make.left.equalTo(logoutView.snp.left).offset(14.68)
            make.right.equalTo(logoutView.snp.right).offset(-14.68)
            make.top.equalTo(logoutView.snp.top).offset(15.88)
            make.bottom.equalTo(logoutView.snp.bottom).offset(-15.88)
        }
    }
    
    //MARK: - ActionFunc
    
    ///MARK: - 로그아웃 기능 버튼
    @objc func clickedBtn(){
        print("hello") // 로그아웃 기능 구현하기
    }
}
