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
    
    ///MARK: - 출석률 or 결석률
    private lazy var percentAttendance: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "KaturiOTF", size: 35)
        label.numberOfLines = 1
        
        if let attributeText = self.mutableCopy() as? NSMutableAttributedString{
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
                    attributeText.addAttributes([.foregroundColor: blueColor], range: range)
                }
            }
            label.attributedText = attributeText
        }
        return label
    }()
    
    ///MARK: - 달력 지우개 버튼
    private lazy var eraserBtn: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "eraser")
        var configuration = UIButton.Configuration.plain()
        configuration.baseBackgroundColor = .clear
        configuration.image = img
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        btn.configuration = configuration
        return btn
    }()
    
    ///MARK: - 캘린더 확인 버튼
    private lazy var checkCalendar: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "schedule")
        var configuration = UIButton.Configuration.plain()
        configuration.baseBackgroundColor = UIColor.clear
        configuration.image = img
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        btn.configuration = configuration
        return btn
    }()
    
    //MARK: - Init
    required init?(coder aDecoder : NSCoder){
        fatalError("error")
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setSelf()
    }
    
    //MARK: - Function
    ///MARK: -setSelf
    private func setSelf(){
        self.isUserInteractionEnabled = true
        self.backgroundColor = UIColor(red: 0.541, green: 0.843, blue: 0.973, alpha: 1)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
        
        self.snp.makeConstraints{ make in
            make.width.equalTo(694)
            make.height.equalTo(263)
        }
    }
    
    private func addView(){
        self.addSubview(attendanceCollectionView)
        
    }
    
    private func makeConstraints(){
        attendanceCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(40)
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.height.equalTo(65)
        }
    }
}

