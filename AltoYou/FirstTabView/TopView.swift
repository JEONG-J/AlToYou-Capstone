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

class TopView: UIImageView {
    ///MARK: - 3D 이미지 뷰
    private lazy var sceneView: SCNView = {
        let sceneView = SCNView()
        let scene = SCNScene(named: "toy_drummer_idle.usdz")
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 9, z: 20)
        scene?.rootNode.addChildNode(cameraNode)
        
        if let object = scene?.rootNode.childNodes.first{
            object.scale = SCNVector3(x: 1.2, y: 1.2, z: 1.2)
            
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
    
    ///MARK: - 로그아웃 버튼
    private lazy var logoutBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("로그아웃", for: .normal)
        btn.titleLabel?.font = UIFont(name: "KaturiOTF", size: 22)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor(red: 0.95, green: 0.62, blue: 0.02, alpha: 1.00)
        btn.layer.cornerRadius = 12
        //     btn.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        return btn
    }()
    
    ///MARK: - 출석 체크 컬렉션 뷰
    private lazy var attendanceCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.layer.backgroundColor = UIColor.clear.cgColor
        cv.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: DayCollectionViewCell.identifier)
        return cv
    }()
    
    //MARK: - init
    required init?(coder: NSCoder){
        fatalError("error")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSelf()
    }
    //MARK: - Function
    
    ///MARK: - self 설정
    private func setSelf(){
        let image = UIImage(named: "topBackground")
        self.image = image
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        self.layer.masksToBounds = true
    }
    
    
    /*
     //MARK: - Extension
     extension TopView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return cellInfor.DayList.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCollectionViewCell.identifier, for: indexPath) as? DayCollectionViewCell else { return UICollectionViewCell() }
     cell.configuration(cellInfor.DayList[indexPath.item])
     return cell
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     return CGSize(width: 55, height: 55)
     }
     // 간격 보고 코드 추가할 예정
     }
     */
}
