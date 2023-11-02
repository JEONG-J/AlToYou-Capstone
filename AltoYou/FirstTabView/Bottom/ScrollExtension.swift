//
//  ScrollExtension.swift
//  AltoYou
//
//  Created by 정의찬 on 11/1/23.
//

import Foundation
import UIKit

extension BottomView: UIScrollViewDelegate{
    ///MARK: - 스크롤 뷰 애니메이셔 적용
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            applyBounds()
        }
    }
    
    ///MARK: - 스크롤뷰 페이지 컨트롤 동기화
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let size = scrollView.contentOffset.x / scrollView.frame.size.width
        selectPage(currentPage: Int(round(size)))
    }
}
