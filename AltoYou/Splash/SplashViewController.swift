//
//  SplashViewController.swift
//  AltoYou
//
//  Created by 정의찬 on 10/22/23.
//

import UIKit
import Lottie
import SnapKit

class SplashViewController: UIViewController {
    
    ///MARK: - 영상 끝나면 바로 화면 넘기기 위함
    private lazy var appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    private let animationView: LottieAnimationView = .init(name: "animation_lo1aspnb")
    var monitor: CADisplayLink?
    
    ///MARK: 자동 텍스트 변환 상태 확인
    private lazy var didChangeText: [Bool] = [false, false, false]
    
    ///MARk: 자동 텍스트 내용 문구 저장
    private var texts: [String] = [
        "동화 속 주인공처럼 \n재미있는 영어 이야기를 만들어 나가요!",
        "신비한 영어 숲의 모험, 준비되셨나요?",
        "당신의 영어 동화 이야기, 지금 시작하세요!"
    ]
    
    private var currentTextIndex: Int = 0
    
    ///MARK: - 온보드 텍스트 화면
    private lazy var onBoardLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "KaturiOTF", size: 70)
        label.textColor = UIColor(red: 0.20, green: 0.55, blue: 0.31, alpha: 1.00)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    ///MARK: - 로티 애니메이션 후 탭바 연결
    private lazy var mainTabBarView: MainTabBarController = {
        let view = MainTabBarController()
        return view
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        splashSetup()
        makeConstraints()
    }
    //MARK: - Function
    
    /// MARK: - 애니메이션 플레이 실시간 모니터링 함수
    private func splashPlay(){
        monitor = CADisplayLink(target: self, selector: #selector(displayAnimation))
        monitor?.add(to: .main, forMode: .default)
        
        animationView.play(fromProgress: 0, toProgress: 1.0)
    }
    
    /// MARK: - 애니메이션 설정 함수
    private func splashSetup(){
        animationView.frame = self.view.bounds
        animationView.loopMode = .playOnce
        animationView.contentMode = .scaleAspectFill
        animationView.animationSpeed = 1.3
        self.view.addSubview(animationView)
        
        splashPlay()
    }
    
    ///MARK: - 라벨 오토레이아웃 설정
    private func makeConstraints(){
        self.view.addSubview(onBoardLabel)
        self.view.bringSubviewToFront(onBoardLabel)
        
        onBoardLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(10)
            make.height.greaterThanOrEqualTo(300)
            make.left.equalToSuperview().offset(40)
            make.width.greaterThanOrEqualTo(580)
        }
    }
    
    ///MARK: - 텍스트 애니메이션 함수
    private func changeTextWithAnimation() {
        UIView.animate(withDuration: 1.0, animations: {
            self.onBoardLabel.alpha = 0  // Fade out
        }, completion: { _ in
            if self.currentTextIndex < self.texts.count - 1 {
                self.currentTextIndex += 1
            } else {
                self.currentTextIndex = 0
            }
            self.onBoardLabel.text = self.texts[self.currentTextIndex]
            
            UIView.animate(withDuration: 1.0) {
                self.onBoardLabel.alpha = 1  // Fade in
                self.setText()
            }
        })
    }
    
    ///MARK: - 텍스트 상태 설정 및 지정 단어 설정
    private func setText(){
        let attrString = NSMutableAttributedString(string: onBoardLabel.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 20
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        
        let highlightRange = UIColor(red: 0.93, green: 0.56, blue: 0.20, alpha: 1.00)
        let highligtedWord = ["영어", "동화", "이야기"]
        
        for word in highligtedWord {
            var range = (onBoardLabel.text! as NSString).range(of: word)
            while range.location != NSNotFound {
                attrString.addAttribute(.foregroundColor, value: highlightRange, range: range)
                let nextRangeStart = range.location + range.length
                range = (onBoardLabel.text! as NSString).range(of: word, options: [], range: NSRange(location: nextRangeStart, length: onBoardLabel.text!.utf16.count - nextRangeStart))
            }
        }
        
        onBoardLabel.attributedText = attrString
    }
    
    ///MARK: - 온보드 끝내고 메인뷰 넘어가는 전환 함수
    private func transitionView(){
        monitor?.invalidate()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
            self.appDelegate?.window?.rootViewController = self.mainTabBarView
            self.appDelegate?.window?.makeKeyAndVisible()
        }
    }
    //MARK: - objc Function
    
    /// MARK: - 애니메이션 중간 화면 넘기기 위한 objc 함수
    @objc func displayAnimation(){
        
        switch animationView.currentProgress {
        case 0.0..<0.3 where !didChangeText[0]:
            changeTextWithAnimation()
            didChangeText[0] = true
        case 0.3..<0.6 where !didChangeText[1]:
            changeTextWithAnimation()
            didChangeText[1] = true
        case 0.6..<0.9 where !didChangeText[2]:
            changeTextWithAnimation()
            didChangeText[2] = true
        case 1.0:
            transitionView()
            
        default:
            break
        }
    }
}
