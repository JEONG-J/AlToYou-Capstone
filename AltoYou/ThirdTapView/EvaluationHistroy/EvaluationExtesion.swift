//
//  EvaluationExtend.swift
//  AltoYou
//
//  Created by 정의찬 on 11/23/23.
//

import Foundation
import UIKit
import SwiftUI

extension ThirdMainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        EvaluationHistroyInfo.evaluationHistoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EvaluationHistroyCollectionViewCell.identifier, for: indexPath) as? EvaluationHistroyCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configuration(model: EvaluationHistroyInfo.evaluationHistoryList[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 982, height: 174)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? EvaluationHistroyCollectionViewCell else { return }
        
        let originalColor = cell.backgroundColor
        let blinkColor = UIColor.gray
        
        let UIHostringController = UIHostingController(rootView: EvaluationView())
        UIHostringController.modalPresentationStyle = .currentContext
        UIHostringController.modalTransitionStyle = .coverVertical
        
        present(UIHostringController, animated: true, completion: nil)
        
        UIView.animate(withDuration: 0.1, animations: {
            cell.backgroundColor = blinkColor
        }) {(finished) in
            UIView.animate(withDuration: 0.1) {
                cell.backgroundColor = originalColor
            }
        }
    }
    
}
