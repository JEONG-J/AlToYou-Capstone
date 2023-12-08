//
//  ThirdMainViewController.swift
//  AltoYou
//
//  Created by 정의찬 on 11/21/23.
//

import UIKit
import SnapKit
import SwiftUI
import Alamofire

class ThirdMainViewController: UIViewController{
    
    var chartAPI: ChartAPI?
    var evaluationHistory: EvaluationHistory?
    var evaluationInfo = EvaluationInfo()
    
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
    private lazy var historyTable: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 32
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(EvaluationHistroyCollectionViewCell.self, forCellWithReuseIdentifier: EvaluationHistroyCollectionViewCell.identifier)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        return cv
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
        fetchDataHistory()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           fetchDataHistory()
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
    
    func fetchDataHistory(){
        let url = "http://13.124.7.35:8080/api/estimation/\(GlobalData.shared.userId ?? "")/estimations"
        
        AF.request(url).responseDecodable(of: EvaluationHistory.self) { [weak self] response in
            switch response.result {
            case .success(let data):
                print("컬렉션 뷰 : 데이터 가져오기완료")
                GlobalData.shared.evaluationHistory = data // Update the global data here
                self?.historyTable.reloadData()
            case.failure(let error):
                print("error : \(error)")
            }
        }
    }

    
    final func popupSheetView(){
        let UIHostingController = UIHostingController(rootView: EvaluationView())
        
        
        if let windowScene = UIApplication.shared.connectedScenes.first(where: {$0.activationState == .foregroundActive}) as? UIWindowScene, let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
            
            let screenSize = keyWindow.bounds.size
            let safeAreaInsets = keyWindow.safeAreaInsets
            let safeAreaHeight = screenSize.height - safeAreaInsets.top - safeAreaInsets.bottom
            
            UIHostingController.preferredContentSize = CGSize(
                width: screenSize.width - 20,
                height: safeAreaHeight
            )
            UIHostingController.modalPresentationStyle = .formSheet
        }
        present(UIHostingController, animated: true, completion: nil)
    }
}
