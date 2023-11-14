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
        view.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeText))
        view.addGestureRecognizer(tapGesture)
        
        return view
    }()

    ///MARK: - 랜덤 텍스트 생성
    private lazy var randomText: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "Goryeong-Strawberry", size: 43)
        text.numberOfLines = 0
        text.text = Message.texts.randomElement()
        text.lineBreakMode = .byWordWrapping
        text.textAlignment = .center
        text.textColor = UIColor.black
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
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(140)
            make.width.greaterThanOrEqualTo(500)
            make.height.greaterThanOrEqualTo(50)
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
    
    //MARK: - Objc Function
    
    ///MARK: - 랜덤 텍스트 생성 액션 버튼
    @objc func changeText(){
        randomText.text = Message.texts.randomElement()
        
        UIView.animate(withDuration: 0.1){
            self.randomText.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { _ in
            UIView.animate(withDuration: 0.1){
                self.randomText.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }
    }
}
