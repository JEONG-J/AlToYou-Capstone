//
//  BottomView.swift
//  AltoYou
//
//  Created by 정의찬 on 10/30/23.
//

import UIKit
import SnapKit

class BottomView: UIImageView{
    
    ///MARK: - 프로필 닉네임 뷰 프로퍼티
    private lazy var profileView: UIImageView = {
        let view = UIImageView()
        let img = UIImage(named: "nameBackgorund")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        view.image = img
        view.isUserInteractionEnabled = true
        return view
    }()
    
    ///MARK: - 사용자 이름
    private lazy var userName: UILabel = {
        let name = UILabel()
        name.font = UIFont(name:"Goryeong-Strawberry", size: 50)
        name.text = "푸앙푸앙"
        return name
    }()
    
    ///MARK: - 스택뷰 프로퍼티
    private lazy var stackView: BottomStackView = {
        let stack = BottomStackView()
        return stack
    }()
    
    ///MARK: - 스크롤뷰 프로퍼티
    private lazy var horizonScrollView: UIScrollView = {
        let view = UIScrollView()
        view.delegate = self
        view.isPagingEnabled = true
        view.bounces = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    ///MARk: - 스크롤뷰 페이지 컨트롤
    private lazy var pageControl: UIPageControl = {
        let page = UIPageControl()
        page.transform = CGAffineTransform(scaleX: 3, y: 3)
        page.currentPage = 0
        page.numberOfPages = stackView.arrangedSubviews.count
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
    
    ///MARK: - 셀프 설정 함수
    private func selfSet(){
        let img = UIImage(named: "bottomBackground")
        self.image = img
        self.isUserInteractionEnabled = true
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
        self.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    }
    
    ///MARK: - 프로퍼티 추가 함수
    private func addView(){
        self.addSubview(horizonScrollView)
        horizonScrollView.addSubview(stackView)
        self.addSubview(pageControl)
        self.addSubview(profileView)
        profileView.addSubview(userName)
    }
    
    ///MARK: - 제약 조건 생성
    private func makeCostraints(){
        addView()
        
        profileView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(130)
            make.left.equalToSuperview().offset(109)
        }
        
        userName.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
        }
        
        horizonScrollView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(130)
            make.left.equalTo(profileView.snp.right).offset(58.52)
            make.right.equalToSuperview().offset(-109)
            make.width.greaterThanOrEqualTo(710)
            make.height.greaterThanOrEqualTo(300)
        }
        
        stackView.snp.makeConstraints{ make in
            make.top.left.bottom.right.equalTo(horizonScrollView)
        }
        
        pageControl.snp.makeConstraints{ make in
            make.top.equalTo(horizonScrollView.snp.bottom).offset(16)
            make.centerX.equalTo(horizonScrollView.snp.centerX)
        }
    }
    
    ///MARK: - 스크롤뷰 페이지 컨트롤 동기화 처리
    public func selectPage(currentPage: Int){
        pageControl.currentPage = currentPage
    }
    
    ///MARK: - 스크롤뷰 애니메이션 처리
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
