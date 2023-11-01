//
//  ScrollExtension.swift
//  AltoYou
//
//  Created by 정의찬 on 11/1/23.
//

import Foundation
import UIKit

extension BottomView: UIScrollViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            applyBounds()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let size = scrollView.contentOffset.x / scrollView.frame.size.width
        selectPage(currentPage: Int(round(size)))
    }
}
