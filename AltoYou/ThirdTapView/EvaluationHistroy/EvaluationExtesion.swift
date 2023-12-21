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
        GlobalData.shared.evaluationHistory?.estimationList.count ?? 0
    //    evaluationInfo.evaluationInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EvaluationHistroyCollectionViewCell.identifier, for: indexPath) as? EvaluationHistroyCollectionViewCell else { return UICollectionViewCell() }
        
        if let esimation = GlobalData.shared.evaluationHistory?.estimationList[indexPath.row] {
            cell.configuration(model: esimation)
        }
      //  cell.configuration(model: evaluationInfo.evaluationInfo[indexPath.row])
    
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
        
        let selectEstimationId = self.evaluationHistory?.estimationList[indexPath.row].estimationId
        chartAPI?.cellGetChartInfo(selectEstimationId ?? "")
        
        
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.1, animations: {
                DispatchQueue.global(qos: .userInteractive).async {
                    selectEffectMusic("cellButton", "wav")
                }
                cell.backgroundColor = blinkColor
            }) {(finished) in
                UIView.animate(withDuration: 0.1, animations: {
                    cell.backgroundColor = originalColor
                }) { [weak self] (finished) in
                    
                    self?.popupSheetView()
                }
            }
        }
    }
}
