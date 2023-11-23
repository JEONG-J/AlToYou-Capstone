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
        let img = UIImage(named: "ThirdTap.png")
        view.image = img
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    ///MARK: - 뷰 제목
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Goryeong-Strawberry", size: 50)
        label.text = "우리가 배운 것들을 발견해보자, 작은 탐험가들!"
        label.textColor = UIColor.black
        return label
    }()
    
    ///MARK: - 회화 항목 히스토리
    private lazy var historyTable: UITableView = {
        let table = UITableView()
        table.layer.borderWidth = 1
        table.layer.borderColor = UIColor.black.cgColor
        return table
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
        self.view.addSubview(titleLabel)
        self.view.bringSubviewToFront(titleLabel)
        self.view.addSubview(historyTable)
        self.view.bringSubviewToFront(historyTable)
    }
    
    ///MARK: - 제약조선
    private func makeConstraints(){
        addProperty()
        
        backgroundImageView.snp.makeConstraints{ make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(123)
            make.left.equalToSuperview().offset(215)
            make.right.equalToSuperview().offset(-215)
            make.height.equalTo(68)
        }
        
        historyTable.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(144)
            make.right.equalToSuperview().offset(-145)
            make.bottom.equalToSuperview().offset(-140)
        }
    }
}
