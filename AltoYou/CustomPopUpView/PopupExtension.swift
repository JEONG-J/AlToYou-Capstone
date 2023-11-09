//
//  PopupExtension.swift
//  AltoYou
//
//  Created by 정의찬 on 11/9/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showPopUp(message: String? = nil,
                   leftActionTitle: String? = nil,
                   rightActionTitle: String? = nil,
                   leftActionCompletion: (() -> Void)? = nil,
                   rightActionCompletion: (() -> Void)? = nil) {
        let popUpViewController = PopUpViewController(messageText: message)
        
        showPopUp(popUpViewController: popUpViewController,
                  leftActionTitle: leftActionTitle,
                  rightActionTitle: rightActionTitle,
                  leftActionCompletion: leftActionCompletion,
                  rightActionCompletion: rightActionCompletion)
    }
    
    func showPopUp(contentView: UIView,
                   leftActionTitle: String? = nil,
                   rightActionTitle: String? = nil,
                   leftActionCompletion: (() -> Void)? = nil,
                   rightActionCompletion: (() -> Void)? = nil) {
        let popUpViewController = PopUpViewController(contentView: contentView)
        
        showPopUp(popUpViewController: popUpViewController,
                  leftActionTitle: leftActionTitle,
                  rightActionTitle: rightActionTitle,
                  leftActionCompletion: leftActionCompletion,
                  rightActionCompletion: rightActionCompletion)
    }
    
    private func showPopUp(popUpViewController: PopUpViewController,
                           leftActionTitle: String?,
                           rightActionTitle: String?,
                           leftActionCompletion: (() -> Void)?,
                           rightActionCompletion: (() -> Void)?) {
        popUpViewController.addActionBtn(title: leftActionTitle) {
            popUpViewController.dismiss(animated: false, completion: leftActionCompletion)
            print("ok")
        }
        
        popUpViewController.addActionBtn(title: rightActionTitle) {
            popUpViewController.dismiss(animated: false, completion: rightActionCompletion)
            print("no")
        }
        present(popUpViewController, animated: false, completion: nil)
    }
}
