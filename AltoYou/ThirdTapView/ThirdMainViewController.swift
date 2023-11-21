//
//  ThirdMainViewController.swift
//  AltoYou
//
//  Created by 정의찬 on 11/21/23.
//

import UIKit
import SnapKit

class ThirdMainViewController: UIViewController {

    ///MARk: - 배경이미지 프로퍼티
    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        let img = UIImage(named: "ThirdMain.png")
        view.image = img
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    ///MARK: - 뷰 제목
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Goryeong-Strawberry", size: 50)
        label.text = "우리의 실력은 어디일까?"
        label.textColor = UIColor.black
        
        return label
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
    }
    

    //MARK: - Function

    ///MAKR: - 프로퍼티 추가
    private func addProperty(){
        self.view.addSubview(backgroundImageView)
    }
    
    ///MARK: - 제약조선
    private func makeConstraints(){
        addProperty()
        
        backgroundImageView.snp.makeConstraints{ make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}
