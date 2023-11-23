//
//  EvaluationHistroyTableViewCell.swift
//  AltoYou
//
//  Created by 정의찬 on 11/22/23.
//

import UIKit
import SnapKit

class EvaluationHistroyTableViewCell: UITableViewCell {
    
    //MARK: - Property
    static let identifier = "EvaluationHistroyTableViewCell"
    
    ///MARK: - 셀 날짜 라벨
    private lazy var evaluationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Goryeong-Strawberry", size: 45)
        label.textColor = UIColor(red: 0.911, green: 0.377, blue: 0.209, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    ///MARK: - 셀 시간 라벨
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Goryeong-Strawberry", size: 45)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    //TODO: - 이미지 넣기
    ///MARK: - 대화 했던 캐릭터 이미지 뷰
    private lazy var talkedCharacterImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .clear
        return view
    }()
    
    //TODO: - 이미지 넣기
    ///MARK: - 셀 선택 버튼 이미지
    private lazy var starImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    //MARK: - Init
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSelf()
    }
    
    //MARK: - Function
    ///MARK: - 자기 설정
    private func setSelf(){
        self.backgroundColor = UIColor(red: 0.909, green: 0.892, blue: 0.892, alpha: 0.8)
        self.layer.cornerRadius = 50
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
    }
    
    ///MARK: - 제약 조건 함수

}
