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
    
    weak var appDelegate: AppDelegate?
    
    var userId: String?
    
    //MARK: - Propertiees
    
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
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
        // Do any additional setup after loading the view.
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
            make.height.lessThanOrEqualTo(200)
        }
    }
    
    private func changeRootView(){
        self.appDelegate?.window?.rootViewController = SplashViewController()
    }
    
    ///MARK: - 카카오 로그인 처리 액션
    private func loginFunction(){
        if (UserApi.isKakaoTalkLoginAvailable()) {
            
            UserApi.shared.loginWithKakaoTalk{ (ouathToken, error) in
                if let error = error{
                    print(error)
                } else{
                    print("success")
                    UserApi.shared.me { user, error in
                        if let error = error {
                            print(error)
                        } else {
                            guard let userId = user?.kakaoAccount?.email else {
                                print("userId not found")
                                return
                            }
                            self.userId = userId
                            
                            //서버에 이메일 보내기
                        }
                    }
                    self.changeRootView()
                }
            }
        } else {
            
            UserApi.shared.loginWithKakaoAccount{ (ouathToken, error) in
                if let error = error{
                    print(error)
                } else{
                    print("success")
                    _ = ouathToken
                }
            }
        }
    }
    //MARK: - objc Function
    
    ///MARK: - 버튼 액션 버튼 추가하기
    @objc func actionAnimation(sender: UIButton){
        
        self.loginFunction()
        
        UIView.animate(withDuration: 0.35){
            sender.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        } completion: { _ in
            UIView.animate(withDuration: 0.35){
                sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }
    }
}
