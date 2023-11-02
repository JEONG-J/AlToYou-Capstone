//
//  SplashViewController.swift
//  AltoYou
//
//  Created by 정의찬 on 10/22/23.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    weak var appDelegate: AppDelegate?
    private let animationView: LottieAnimationView = .init(name: "animation_lo1aspnb")
    var monitor: CADisplayLink?
    private lazy var mainTabBarView: MainTabBarController = {
        let view = MainTabBarController()
        return view
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        splashSetup()
    }
    //MARK: - Function
    /// MARK: - 애니메이션 플레이 실시간 모니터링 함수
    private func splashPlay(){
        monitor = CADisplayLink(target: self, selector: #selector(displayAnimation))
        monitor?.add(to: .main, forMode: .default)
        
        animationView.play(fromProgress: 0, toProgress: 0.5)
    }
    
    /// MARK: - 애니메이션 설정 함수
    private func splashSetup(){
        animationView.frame = self.view.bounds
        animationView.loopMode = .playOnce
        animationView.contentMode = .scaleAspectFill
        animationView.animationSpeed = 1.5
        self.view.addSubview(animationView)
        
        splashPlay()
    }
    //MARK: - objc Function
    /// MARK: - 애니메이션 중간 화면 넘기기 위한 objc 함수
    @objc func displayAnimation(){
        if animationView.currentProgress == 0.5{
            
            monitor?.invalidate()
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                self.appDelegate?.window?.rootViewController = self.mainTabBarView
                self.appDelegate?.window?.makeKeyAndVisible()
            }
        }
    }
}
