//
//  BottomView.swift
//  AltoYou
//
//  Created by 정의찬 on 10/30/23.
//

import UIKit

class BottomView: UIImageView{
    
    private lazy var stackView: BottomStackView = {
        let stack = BottomStackView()
        return stack
    }()
    
    //TODO: - 프로필 뷰 따로 분리하기
    ///MARK: - 프로필 닉네임 뷰
    private lazy var profileView: UIImageView = {
        let view = UIImageView()
        let img = UIImage(named: "nicknameView")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        view.image = img
        view.isUserInteractionEnabled = true
        return view
    }()
    
    
    private lazy var horizonScrollView: UIScrollView = {
        let view = UIScrollView()
        view.delegate = self
        view.isPagingEnabled = true
        view.bounces = true
        return view
    }()
    
    private lazy var pageControl: UIPageControl = {
        let page = UIPageControl()
        page.transform = CGAffineTransform(scaleX: 3, y: 3)
        page.currentPage = 0
        page.numberOfPages = 3
        page.pageIndicatorTintColor = .lightGray
        page.currentPageIndicatorTintColor = UIColor(red: 0.27, green: 0.60, blue: 0.86, alpha: 1.00)
        return page
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        selfSet()
        makeCostraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Function
    private func selfSet(){
        let img = UIImage(named: "bottomBackground")
        self.image = img
        self.isUserInteractionEnabled = true
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
        self.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    }
    
    private func makeCostraints(){
        self.addSubview(horizonScrollView)
        horizonScrollView.addSubview(stackView)
        self.addSubview(pageControl)
        
        horizonScrollView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(140)
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(710)
            make.height.greaterThanOrEqualTo(300)
        }
        
        stackView.snp.makeConstraints{make in
            make.top.left.bottom.right.equalTo(horizonScrollView)
        }
        
        pageControl.snp.makeConstraints{make in
            make.top.equalTo(horizonScrollView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
    }
    
    public func selectPage(currentPage: Int){
        pageControl.currentPage = currentPage
    }
    
    public func applyBounds(){
        let bounceDuration: TimeInterval = 0.5
        let bounceScale: CGFloat = 1.2
        
        UIView.animate(withDuration: bounceDuration, animations: {
            self.horizonScrollView.transform = CGAffineTransform(scaleX: bounceScale, y: bounceScale)
        }) { (finished) in
            UIView.animate(withDuration: bounceDuration){
                self.horizonScrollView.transform = .identity
            }
        }
    }
}
