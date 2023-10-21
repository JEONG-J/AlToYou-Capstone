//
//  MainViewController.swift
//  AltoYou
//
//  Created by 정의찬 on 10/3/23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private lazy var topView: TopView = {
        let view = TopView()
        return view
    }()
    
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        makeConstraints()
    }
    
    // MARK: - Function
    private func makeConstraints(){
        self.view.addSubview(topView)
        
        topView.snp.makeConstraints{ (make) -> Void in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(390)
        
        }
    }
    
    

}
