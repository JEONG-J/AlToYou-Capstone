//
//  bottomStackView.swift
//  AltoYou
//
//  Created by 정의찬 on 10/30/23.
//

import UIKit
import SnapKit

class BottomStackView: UIStackView {
    
    ///MARK: - 출석 뷰
    private lazy var attendanceView: AttendanceView = {
        let view = AttendanceView()
        return view
    }()
    
    ///MARK: - 랜덤 텍스브 뷰
    private lazy var randomTextView: UIImageView = {
        let view = UIImageView()
        let img = UIImage(named: "randomTitle")
        view.image = img
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()

    ///MARK: - 랜덤 텍스트 생성
    private lazy var randomText: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "Goryeong-Strawberry", size: 40)
        text.text = "안녕 잘 지냈어??"
        text.numberOfLines = 0
        text.lineBreakMode = .byWordWrapping
        return text
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSelf()
        addImgInStack()
    }
    
    required init(coder: NSCoder){
        fatalError("error")
    }
    
    //MARK: - Function
    
    ///MARK: - Self설정
    private func setSelf(){
        self.axis = .horizontal
        self.alignment = .center
        self.distribution = .fillEqually
        self.spacing = 20
    }
    
    ///MARK: - 이미지 내 텍스트 삽입
    private func addTextInImgView(){
        randomTextView.addSubview(randomText)
        
        randomText.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    ///MARK: - 스택뷰에 뷰 추가하기
    private func addImgInStack(){
        addTextInImgView()
        
        self.addArrangedSubview(attendanceView)
        self.addArrangedSubview(randomTextView)
    
        attendanceView.snp.makeConstraints{ make in
            make.top.left.bottom.equalToSuperview()
        }
        
    }
}
