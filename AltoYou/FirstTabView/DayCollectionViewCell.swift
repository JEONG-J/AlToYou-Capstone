//
//  DayCollectionViewCell.swift
//  AltoYou
//
//  Created by 정의찬 on 10/6/23.
//

import UIKit
import SnapKit

class DayCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DayCollectionViewCell"
    
    private lazy var dayTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "KaturiOTF", size: 25)
        label.textColor = UIColor.gray
        return label
    }()
    
    private lazy var checkImg: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    //MARK: -init
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setSelf()
        prepareForReuse()
    }
    //MARK: - function
    ///MARK: - 셀 설정
    private func setSelf(){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.layer.frame.height / 2
    }
    
    ///MARK: - 셀 재사용
    override func prepareForReuse() {
        super.prepareForReuse()
        dayTitle.text = nil
        dayTitle.layer.borderColor = UIColor.clear.cgColor
        dayTitle.layer.borderWidth = 0
    }
    
    ///MARK: - 제약 조건 생성
    private func makeConstraintsTitle(){
        self.addSubview(dayTitle)
        self.bringSubviewToFront(dayTitle)
        dayTitle.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func makeConstraintsImg(){
        self.addSubview(checkImg)
        self.bringSubviewToFront(checkImg)
        checkImg.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    ///MARK: - 출석체크
    private func isCheck(){
        makeConstraintsImg()
        self.backgroundColor = UIColor(red: 0.02, green: 0.78, blue: 0.95, alpha: 1.00)
        self.layer.borderColor = UIColor(red: 0.02, green: 0.78, blue: 0.95, alpha: 1.00).cgColor
        self.layer.borderWidth = 2
        let img = UIImage(named: "check.png")
        let resizedImg = img?.resizeImage(targetSize: CGSize(width: 26, height: 26))
        checkImg.image = resizedImg
        checkImg.contentMode = .scaleAspectFit
    }
    ///MARK: - 요일표시
    private func notCheck(_ model: DayModel){
        makeConstraintsTitle()
        self.backgroundColor = UIColor.gray
        dayTitle.text = model.day
        dayTitle.textColor = UIColor.white
    }
    
    ///MARK: - 출석체크 요일 버튼
    func configuration(_ model: DayModel){
        if model.isCheck == true {
            isCheck()
        } else {
            notCheck(model)
        }
    }
}
