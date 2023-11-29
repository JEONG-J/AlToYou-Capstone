//
//  SocialLogin.swift
//  AltoYou
//
//  Created by 정의찬 on 11/13/23.
//

import UIKit
import SnapKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser


class SocialLoginView: UIViewController {
    

    private lazy var appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    
    var userId: String?
    
    //MARK: - Propertiees
    
    private lazy var nextView: SplashViewController = {
        let view = SplashViewController()
        return view
    }()
    
    ///MARK: - 로그인 프로퍼티
    private lazy var loginView: UIImageView = {
        let view = UIImageView()
        let img = UIImage(named: "loginImg.png")
        view.image = img
        view.contentMode = .scaleToFill
        view.isUserInteractionEnabled = true
        return view
    }()
    
    ///MARK: - 버튼 프로퍼티
    private lazy var loginBtn: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "kakaologin.png")
        btn.setImage(img, for: .normal)
        
        btn.addTarget(self, action: #selector(actionAnimation(sender :)), for: .touchUpInside)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 30
        return btn
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
    }
    
    //MARK: - Function
    
    ///MARK: - 뷰 추가하기
    private func addViewContents(){
        self.view.addSubview(loginView)
        loginView.addSubview(loginBtn)
    }
    
    
    ///MARK: - 뷰 위치 설정
    private func makeConstraints(){
        addViewContents()
        
        loginView.snp.makeConstraints{ make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        loginBtn.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(420)
            make.right.equalToSuperview().offset(-420)
            make.bottom.equalToSuperview().offset(-90)
            make.height.lessThanOrEqualTo(130)
        }
    }
    
    ///MARK : - 루트뷰 변경
    private func changeRootView(){
        
        DispatchQueue.main.async{
            self.appDelegate?.window?.rootViewController = self.nextView
            self.appDelegate?.window?.makeKeyAndVisible()
            startMusic("backgroundMusic")
        }
        
    }
    
    ///MARK: - 카카오 로그인 처리 액션
    private func loginFunction(){
        if (UserApi.isKakaoTalkLoginAvailable()) {
            
            UserApi.shared.loginWithKakaoTalk{ (ouathToken, error) in
                if let error = error{
                    print(error)
                } else{
                    print("success")
                    self.changeRootView()
                    DispatchQueue.global().async {
                        UserApi.shared.me { [weak self]user, error in
                            if let error = error {
                                print(error)
                            } else {
                                guard let userId = user?.kakaoAccount?.email, let username = user?.kakaoAccount?.profile?.nickname else {
                                    print("userId not found")
                                    return
                                }
                                self?.userId = userId
                                GlobalData.shared.userNickname = username
                                print(userId)
                                print(username)
                                
                                //서버에 이메일 보내기
                            }
                            
                        }
                    }
                }
            }
        }
    }
    //MARK: - objc Function
    ///MARK: - 버튼 액션 버튼 추가하기
    @objc func actionAnimation(sender: UIButton){
        selectMenu("startSound", "wav")
        loginFunction()
        
        UIView.animate(withDuration: 0.35){
            sender.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        } completion: { _ in
            UIView.animate(withDuration: 0.35){
                sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }
    }
}
