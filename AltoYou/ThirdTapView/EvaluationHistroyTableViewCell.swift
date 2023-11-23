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
        makeConstraints()
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
        self.layer.masksToBounds = false
    }
    
    ///MARK: - 프로퍼티 추가 함수
    private func addProperty(){
        self.addSubview(talkedCharacterImageView)
        self.addSubview(evaluationLabel)
        self.addSubview(timeLabel)
        self.addSubview(starImageView)
    }
    
    ///MARK: - 제약 조건 설정
    private func makeConstraints(){
        addProperty()
        
        talkedCharacterImageView.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(74)
            make.top.equalToSuperview().offset(7)
            make.bottom.equalToSuperview().offset(-7)
            make.width.equalTo(131)
        }
        
        evaluationLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(33)
            make.left.equalTo(talkedCharacterImageView.snp.right).offset(133)
            make.width.greaterThanOrEqualTo(320)
            make.height.equalTo(53)
        }
        
        timeLabel.snp.makeConstraints{ make in
            make.left.equalTo(talkedCharacterImageView.snp.right).offset(203)
            make.top.equalTo(evaluationLabel.snp.bottom).offset(2)
            make.bottom.equalToSuperview().offset(-33)
            make.width.greaterThanOrEqualTo(190)
        }
        
        starImageView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(37)
            make.bottom.equalToSuperview().offset(-36)
            make.right.equalToSuperview().offset(-28)
            make.left.equalTo(evaluationLabel.snp.right).offset(161)
        }
    }
    
    //TODO: 작성할 부분
    func configuration(){
        
    }

}
