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
import AVFoundation
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class TopView: UIView {
    
    private lazy var appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    private lazy var sceneController: SceneCotroller = SceneCotroller()
    
    ///MARK: - 3D 이미지 뷰
    private lazy var sceneView: SCNView = {
        let sceneView = SCNView()
        let scene = sceneController.set3DCharacter("toy_biplane_idle.usdz")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickedView))
        sceneController.configureSceneView(sceneView)
        sceneView.addGestureRecognizer(tapGesture)
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
    
    ///MARK: - 로그아웃 버튼 제약조건
    private func logoutMakeConstraints(){
        logoutView.addSubview(logoutBtn)
        
        logoutBtn.snp.makeConstraints{ (make) in
            make.left.equalTo(logoutView.snp.left).offset(14.68)
            make.right.equalTo(logoutView.snp.right).offset(-14.68)
            make.top.equalTo(logoutView.snp.top).offset(15.88)
            make.bottom.equalTo(logoutView.snp.bottom).offset(-15.88)
        }
    }
    
    
    private func changeRootView(){
        
        DispatchQueue.main.async{
            self.appDelegate?.window?.rootViewController = SocialLoginView()
            self.appDelegate?.window?.makeKeyAndVisible()
        }
    }
    
    private func logoutKakao(){
        UserApi.shared.unlink{ (error) in
            if let error = error {
                print(error)
            }
            else {
                print("success")
                self.changeRootView()
            }
        }
    }
    
    //MARK: - ActionFunc
    
    ///MARK: - 로그아웃 기능 버튼
    @objc func clickedBtn(){
        selectMenu("outSound", "wav")
        backgroundMusicPlayer?.stop()
        logoutKakao()
    }
    
    @objc func clickedView(){
        playSoundEffect("propeller", 1.0)
    }
}
