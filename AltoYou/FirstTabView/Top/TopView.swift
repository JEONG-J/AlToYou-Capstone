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
        sceneController.configureSceneView(sceneView,true)
        sceneView.addGestureRecognizer(tapGesture)
        sceneView.scene = scene
        return sceneView
    }()
    
    ///MARK: - 로그아웃 이미지
    private lazy var logoutBtn: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "door.png")
        btn.setImage(img, for: .normal)
        btn.addTarget(self, action: #selector(logoutBtnAction), for: .touchUpInside)
        return btn
    }()
    
    ///MARK: - 토큰 삭제 버튼
    private lazy var deleteToken: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "smile.png")
        btn.setImage(img, for:.normal)
        btn.addTarget(self, action: #selector(deleteTokenAction), for: .touchUpInside)
        return btn
    }()
    
    ///MARK: - 로그아웃 뷰
    private lazy var logoutView: UIView = {
        return  createlogOutView()
    }()
    
    ///MARK: - 토큰 삭제 뷰
    private lazy var deleteTokenView: UIView = {
        return createlogOutView()
    }()
    
    private lazy var logoutGuideText: UILabel = {
        return createLabel("로그아웃")
    }()
    
    private lazy var deleteTokeGuideText: UILabel = {
        return createLabel("정보 삭제")
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
    
    ///MARK: -  중복 뷰 생성
    private func createlogOutView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.075, green: 0.075, blue: 0.196, alpha: 0.62).withAlphaComponent(0.62)
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        return view
    }
    
    ///MARK: - 중복 라벨 생성
    private func createLabel(_ textValue: String) -> UILabel {
        let text = UILabel()
        text.font = UIFont(name: "KaturiOTF", size: 20)
        text.textColor = UIColor.white
        text.textAlignment = .center
        text.text = textValue
        return text
    }
    
    ///MARK: - 뷰 추가
    private func addItem(){
        self.addSubview(sceneView)
        self.bringSubviewToFront(sceneView)
        self.addSubview(logoutView)
        self.bringSubviewToFront(logoutView)
        self.addSubview(deleteTokenView)
        self.bringSubviewToFront(deleteTokenView)
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
        
        deleteTokenView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.right.equalTo(logoutView.snp.left).offset(-50)
            make.bottom.equalToSuperview().offset(-264)
            make.width.lessThanOrEqualTo(124)
            make.height.lessThanOrEqualTo(135)
        }
    }
    
    ///MARK: - 로그아웃 버튼 제약조건
    private func logoutMakeConstraints(){
        logoutView.addSubview(logoutBtn)
        logoutView.addSubview(logoutGuideText)
        deleteTokenView.addSubview(deleteToken)
        deleteTokenView.addSubview(deleteTokeGuideText)
        
        logoutBtn.snp.makeConstraints{ (make) in
            make.left.equalTo(logoutView.snp.left).offset(19)
            make.right.equalTo(logoutView.snp.right).offset(-17)
            make.top.equalTo(logoutView.snp.top).offset(16)
            make.bottom.equalTo(logoutGuideText.snp.top).offset(-5)
        }
        
        logoutGuideText.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(30)
        }
        
        deleteToken.snp.makeConstraints{ make in
            make.left.equalTo(deleteTokenView.snp.left).offset(21)
            make.right.equalTo(deleteTokenView.snp.right).offset(-21)
            make.top.equalTo(deleteTokenView.snp.top).offset(16)
            make.bottom.equalTo(deleteTokeGuideText.snp.top).offset(-9)
        }
        
        deleteTokeGuideText.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(30)
        }
    }
    
    ///MARK: - 루트 뷰 변경
    private func changeRootView(){
        DispatchQueue.main.async{
            self.appDelegate?.window?.rootViewController = SocialLoginView()
            self.appDelegate?.window?.makeKeyAndVisible()
        }
    }
    
    ///MARK: - 카카오톡 로그아웃(토큰 존재)
    private func logOutKakao(){
        UserApi.shared.logout{ error in
            if let error = error {
                print(error)
            } else {
                print("success")
                self.changeRootView()
            }
        }
    }
    
    ///MARK: - 토큰 삭제
    private func tokenDeleteKakao(){
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
    @objc func logoutBtnAction(){
        selectEffectMusic("outSound", "wav")
        showPopUp(message: "로그아웃을 진행할까요??", leftActionTitle: "Yes", rightActionTitle: "No", leftActionCompletion: {
            self.logOutKakao()
            backgroundMusicPlayer?.stop()
        }, rightActionCompletion: {
            backgroundMusicPlayer?.play()
        })
        
    }
    ///MARk: - 비행기 사운드 효과
    @objc func clickedView(){
        selectEffectMusic("propeller", "mp3")
    }
    
    ///MARK: - 사운드 효과 주기
    @objc func deleteTokenAction(){
        selectEffectMusic("deleteSound", "wav")
        showPopUp(message: "회원정보 삭제를 진행할까요??", leftActionTitle: "Yes", rightActionTitle: "No", leftActionCompletion: {
            self.tokenDeleteKakao()
            backgroundMusicPlayer?.stop()
        }, rightActionCompletion: {
            backgroundMusicPlayer?.play()
        })
        
    }
}
