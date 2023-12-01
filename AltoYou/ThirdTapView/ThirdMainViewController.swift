//
//  ThirdMainViewController.swift
//  AltoYou
//
//  Created by 정의찬 on 11/21/23.
//

import UIKit
import SnapKit
import FloatingPanel
import SwiftUI

class ThirdMainViewController: UIViewController, FloatingPanelControllerDelegate {
    
    private var activeFloatingPanel: FloatingPanelController?

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
    
    final func checkSheet(){
        if let existingPanel = activeFloatingPanel {
            existingPanel.dismiss(animated: true) {
                self.makeSheet()
            }
        } else {
            makeSheet()
        }
    }
     
    final func makeSheet(){
        let apper = SurfaceAppearance()
        apper.cornerRadius = 16
        
        
        let fpc = FloatingPanelController()
        let UIHostingController = UIHostingController(rootView: EvaluationView())
        fpc.delegate = self
        fpc.layout = SetFloatingPanelLayout()
        let contentVC = UIHostingController
        fpc.set(contentViewController: contentVC)
     //   fpc.isRemovalInteractionEnabled = true
        fpc.surfaceView.appearance = apper
        
        activeFloatingPanel = fpc
        
        fpc.addPanel(toParent: self, animated: true, completion: nil)
    }
}

class SetFloatingPanelLayout: FloatingPanelLayout{
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .full
    let anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] = [
        .full: FloatingPanelLayoutAnchor(absoluteInset: 30.0, edge: .top, referenceGuide: .safeArea),
        .half: FloatingPanelLayoutAnchor(fractionalInset: 0.43, edge: .bottom, referenceGuide: .superview),
        .tip: FloatingPanelLayoutAnchor(absoluteInset: 10, edge: .bottom, referenceGuide: .superview)
    ]
}
