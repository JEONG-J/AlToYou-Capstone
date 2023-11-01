//
//  MainViewController.swift
//  AltoYou
//
//  Created by 정의찬 on 10/3/23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    //NOTE: - 글꼴 정보 Goryeong-Strawberry
    
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
    }
    
    // MARK: - Function
    
    ///MARK: - 뷰 추가
    private func addView(){
        self.view.addSubview(topView)
        self.view.addSubview(bottomView)
    }
    private func makeConstraints(){
        addView()
        
        topView.snp.makeConstraints{ (make) -> Void in
            make.top.left.right.equalToSuperview()
            make.height.lessThanOrEqualTo(439)
        }
        
        bottomView.snp.makeConstraints{ (make) -> Void in
            make.left.right.equalToSuperview()
            make.top.equalTo(topView.snp.bottom).offset(16)
        }
    }
    
    

}
