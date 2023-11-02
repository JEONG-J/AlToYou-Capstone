//
//  AttendanceView.swift
//  AltoYou
//
//  Created by 정의찬 on 10/31/23.
//

import UIKit

class AttendanceView: UIView {
    
    ///MARK: - 출석 체크 컬렉션 뷰
    private lazy var attendanceCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.layer.backgroundColor = UIColor.clear.cgColor
        cv.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: DayCollectionViewCell.identifier)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    ///MARK: - 출석률 결석률 텍스트 스택뷰
    private lazy var textStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 27
        view.distribution = .fillEqually
        return view
    }()
    
    ///MARK: - 출석률
    private lazy var attendText: UILabel = {
        let label = UILabel()
        return label
    }()
    
    ///MARK: - 결석률
    private lazy var absenceText: UILabel = {
        let label = UILabel()
        return label
    }()
    
    ///MARK: - 출석 이베튼 버튼 스택뷰
    private lazy var btnStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 55
        view.distribution = .equalSpacing
        view.isUserInteractionEnabled = true
        return view
    }()
    
    ///MARK: - 달력 지우개 버튼
    private lazy var eraserBtn: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "eraser")?.resizeImage(targetSize: CGSize(width: 85, height: 88))
        btn.setImage(img, for: .normal)
        btn.addTarget(self, action: #selector(removeAttendace), for: .touchUpInside)
        return btn
    }()
    
    ///MARK: - 캘린더 확인 버튼
    private lazy var checkCalendar: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "schedule")?.resizeImage(targetSize: CGSize(width: 90, height: 88))
        btn.setImage(img, for: .normal)
        btn.addTarget(self, action: #selector(showCalendar), for: .touchUpInside)
        return btn
    }()
    
    //MARK: - Init
    required init?(coder aDecoder : NSCoder){
        fatalError("error")
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setSelf()
        makeConstraints()
    }
    
    //MARK: - Function
    
    ///MARK: - setSelf
    private func setSelf(){
        self.backgroundColor = UIColor(red: 0.541, green: 0.843, blue: 0.973, alpha: 1)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
    }
    
    private func makeString(_ text: String) -> UILabel{
        let label = UILabel()
        label.font = UIFont(name: "KaturiOTF", size: 35)
        label.numberOfLines = 1
        
        let attributeText = NSMutableAttributedString(string: text)
        let blueColor = UIColor.blue
        let redColor = UIColor.red
        let blueWord = ["출석률"]
        let redWord = ["결석률"]
        
        for i in blueWord{
            let range = (attributeText.string as NSString).range(of: i)
            if range.location != NSNotFound{
                attributeText.addAttributes([.foregroundColor: blueColor], range: range)
            }
        }
        
        for i in redWord{
            let range = (attributeText.string as NSString).range(of: i)
            if range.location != NSNotFound{
                attributeText.addAttributes([.foregroundColor: redColor], range: range)
            }
        }
        label.attributedText = attributeText
        return label
    }
    
    ///MARK: - 출석 / 결석 텍스트 설정
    private func setAttendanceText(){
        attendText = makeString("출석률 : 10% / 100%")
        absenceText = makeString("결석률 : 75% / 100%")
    }
    
    ///MARK: - 프로퍼티 뷰 추가함수
    private func addView(){
        self.addSubview(attendanceCollectionView)
        self.addSubview(textStackView)
        self.addSubview(btnStackView)
        
        textStackView.addArrangedSubview(attendText)
        textStackView.addArrangedSubview(absenceText)
        btnStackView.addArrangedSubview(eraserBtn)
        btnStackView.addArrangedSubview(checkCalendar)
    }
    
    ///MARK: - 제약 조건 설정
    private func makeConstraints(){
        setAttendanceText()
        addView()
        
        attendanceCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(40)
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualTo(580)
            make.height.lessThanOrEqualTo(65)
        }
        
        textStackView.snp.makeConstraints{ make in
            make.top.equalTo(attendanceCollectionView.snp.bottom).offset(21)
            make.left.equalTo(attendanceCollectionView.snp.left)
            make.width.greaterThanOrEqualTo(331)
        }
        
        btnStackView.snp.makeConstraints{ make in
            make.top.equalTo(attendanceCollectionView.snp.bottom).offset(21)
            make.right.equalTo(attendanceCollectionView.snp.right)
        }
    }
    
    //MARK: - ActionFunction
    
    ///MARK: - 출석현황 삭제
    @objc func removeAttendace(){
        print("hello")
    }
    
    ///MARK: - 캘린더 보기
    @objc func showCalendar(){
        print("hello")
    }
}

