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
            selectEffectMusic("selectCharacter", "wav")
        }
        
        popUpViewController.addActionBtn(title: rightActionTitle) {
            popUpViewController.dismiss(animated: false, completion: rightActionCompletion)
            selectEffectMusic("selectCharacter", "wav")
        }
        present(popUpViewController, animated: false, completion: nil)
    }
}

extension UIView {
    
    func showPopUp(message: String? = nil,
                   leftActionTitle: String? = nil,
                   rightActionTitle: String? = nil,
                   leftActionCompletion: (() -> Void)? = nil,
                   rightActionCompletion: (() -> Void)? = nil) {
        guard let viewController = findViewController() else { return }
        
        viewController.showPopUp(message: message,
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
        guard let viewController = findViewController() else { return }
        
        viewController.showPopUp(contentView: contentView,
                                leftActionTitle: leftActionTitle,
                                rightActionTitle: rightActionTitle,
                                leftActionCompletion: leftActionCompletion,
                                rightActionCompletion: rightActionCompletion)
    }

    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            responder = nextResponder
        }
        return nil
    }
}

