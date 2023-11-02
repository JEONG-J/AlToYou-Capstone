//
//  MainViewController.swift
//  AltoYou
//
//  Created by 정의찬 on 10/3/23.
//

import UIKit
import SnapKit
import Lottie

class MainViewController: UIViewController {
    
    //NOTE: - 글꼴 정보 Goryeong-Strawberry
    
    private lazy var animationView: LottieAnimationView = .init(name: "cloudAni")
    
    ///MARk: - 상단뷰 불러오기
    private lazy var topView: TopView = {
        let view = TopView(frame: self.view.bounds)
        return view
    }()
    
    ///MARK: - 하단뷰 불러오기
    private lazy var bottomView: BottomView = {
        let view = BottomView(frame: self.view.bounds)
        return view
    }()
    
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.15, green: 0.12, blue: 0.24, alpha: 1.00)
        makeConstraints()
        splashSetup()
    }
    
    // MARK: - Function
    
    private func splashSetup(){
        animationView.layer.cornerRadius = 20
        animationView.layer.masksToBounds = true
        animationView.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        animationView.play()
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
    }
    
    ///MARK: - 뷰 추가
    private func addView(){
        self.view.addSubview(animationView)
        animationView.addSubview(topView)
        self.view.addSubview(bottomView)
    }
    private func makeConstraints(){
        addView()
        
        animationView.snp.makeConstraints{ (make) -> Void in
            make.top.left.right.equalToSuperview()
            make.height.lessThanOrEqualTo(439)
        }
      
        topView.snp.makeConstraints{ make -> Void in
            make.left.right.top.bottom.equalToSuperview()
        }
       
        bottomView.snp.makeConstraints{ (make) -> Void in
            make.left.right.equalToSuperview()
            make.top.equalTo(animationView.snp.bottom).offset(16)
        }
    }
    
    
    
}
