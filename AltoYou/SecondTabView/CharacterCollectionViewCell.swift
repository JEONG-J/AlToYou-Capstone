//
//  CharacterCollectionViewCell.swift
//  AltoYou
//
//  Created by 정의찬 on 11/3/23.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    ///MARK: - 캐릭터 이름 프로퍼티
    private lazy var nameText: UILabel = {
        let text = UILabel()
        text.text = "흰둥이"
        text.font = UIFont(name: "Goryeong-Strawberry", size: 30)
        return text
    }()
    
    ///MARK: - 캐릭터 배경 프로퍼티
    private lazy var chracterBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 30
        view.layer.shadowColor = UIColor(red: 0.071, green: 0.068, blue: 0.068, alpha: 0.25).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 2, height: 4)
        return view
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder : NSCoder){
        fatalError("error")
    }
    
    
}
