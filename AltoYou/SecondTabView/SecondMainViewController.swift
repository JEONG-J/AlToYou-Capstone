//
//  SecondMainViewController.swift
//  AltoYou
//
//  Created by 정의찬 on 10/4/23.
//

import UIKit
import SnapKit

class SecondMainViewController: UIViewController {
    
    ///MARK: - 배경 이미지 프로퍼티
    private lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        let img = UIImage(named: "secondView")
        view.image = img
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    ///MARK: - 텍스트 프로퍼티
    private lazy var titleText: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "Goryeong-Strawberry", size: 50)
        text.text = "같이 얘기하고 싶은 동물 친구를 골라볼래요??"
        return text
    }()
    
    ///MARK: - 컬렉션 뷰
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 133
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.layer.backgroundColor = UIColor.clear.cgColor
        return cv
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
    }
    
    //MARK: - Function
    
    private func addView(){
        self.view.addSubview(backgroundView)
        self.view.addSubview(titleText)
    }
    
    private func makeConstraints(){
        addView()
        
        backgroundView.snp.makeConstraints{ make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        titleText.snp.makeConstraints{ make in
            make.top.equalTo(123)
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualTo(911)
        }
    }
}
