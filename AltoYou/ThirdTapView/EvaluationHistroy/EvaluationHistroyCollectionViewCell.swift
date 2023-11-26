//
//  EvaluationHistroyTableViewCell.swift
//  AltoYou
//
//  Created by 정의찬 on 11/22/23.
//

import UIKit
import SnapKit

class EvaluationHistroyCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Property
    static let identifier = "EvaluationHistroyCollectionViewCell"
    
    ///MARK: - 셀 날짜 라벨
    private lazy var evaluationDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Goryeong-Strawberry", size: 45)
        label.textColor = UIColor(red: 0.911, green: 0.377, blue: 0.209, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    ///MARK: - 셀 시간 라벨
    private lazy var evaluationTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Goryeong-Strawberry", size: 45)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    ///MARK: - 대화 했던 캐릭터 이미지 뷰
    private lazy var talkedCharacterImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .clear
        return view
    }()
    
    ///MARK: - 셀 선택 버튼 이미지
    private lazy var starImageView: UIImageView = {
        let view = UIImageView()
        let img = UIImage(named: "star.png")?.resizeImage(targetSize: CGSize(width: 116, height: 101))
        view.image = img
        view.contentMode = .scaleAspectFit
        return view
    }()

    //MARK: - Init
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        evaluationDateLabel.text = ""
        evaluationTimeLabel.text = ""
        talkedCharacterImageView.image = UIImage()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSelf()
        makeConstraints()
        prepareForReuse()
    }
    //MARK: - Function
    ///MARK: - 자기 설정
    final func setSelf(){
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
        self.addSubview(evaluationDateLabel)
        self.addSubview(evaluationTimeLabel)
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
        
        evaluationDateLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(33)
            make.left.equalTo(talkedCharacterImageView.snp.right).offset(133)
            make.width.greaterThanOrEqualTo(320)
            make.height.equalTo(53)
        }
        
        evaluationTimeLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(evaluationDateLabel.snp.bottom).offset(2)
            make.bottom.equalToSuperview().offset(-33)
            make.width.greaterThanOrEqualTo(190)
        }
        
        starImageView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(37)
            make.bottom.equalToSuperview().offset(-36)
            make.right.equalToSuperview().offset(-28)
            make.left.equalTo(evaluationDateLabel.snp.right).offset(161)
        }
    }
    
    ///MARK: - 셀 초기화
    public func configuration(model: EavaluationHistoryModel){
        let img = UIImage(named: model.evaluationCharacter)?.resizeImage(targetSize: CGSize(width: 131, height: 167))
        talkedCharacterImageView.image = img
        evaluationDateLabel.text = parsingDate(date: model.evaluationDate)
        evaluationTimeLabel.text = parsingTime(date: model.evaluationDate)
        
    }
    
    ///MARK: - 날짜 파싱
    private func parsingDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yy / MM / dd(E)"
        return dateFormatter.string(from: date)
    }
    
    ///MARK: - 시간 파싱
    private func parsingTime(date: Date) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.locale = Locale(identifier: "ko_KR")
        timeFormatter.dateFormat = "a h:mm"
        return timeFormatter.string(from: date)
    }

}
