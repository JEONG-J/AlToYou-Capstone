//
//  MainTabBarController.swift
//  AltoYou
//
//  Created by 정의찬 on 10/4/23.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    lazy var layer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let space = tabBar.bounds.width * 0.30
        setSelf(space, 30)
        addTab()
        setupNotificationCenterObserver()
    }
    
    //MARK: - Function
    
    private func setupNotificationCenterObserver() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("CloseARView"), object: nil, queue: nil) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
    }

    
    private func setSelf(_ space: CGFloat, _ addHeight: CGFloat){
        let x: CGFloat = space
        let width: CGFloat = tabBar.bounds.width - (x * 2)
        let baseHeight: CGFloat = 49
        let currentHeight: CGFloat = baseHeight + addHeight
        let y: CGFloat = -(addHeight/2 + 0)
        
        let path = UIBezierPath(roundedRect: CGRect(x: x, y: y, width: width, height: currentHeight), cornerRadius: currentHeight / 2).cgPath
        layer.path = path
        
        layer.fillColor = UIColor(red: 0.50, green: 0.91, blue: 1.00, alpha: 1.00).cgColor
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.5
        
        self.tabBar.layer.insertSublayer(layer, at: 0)
        self.tabBar.itemPositioning = .centered
    }
    
    private func addTab(){
        let targetSize = CGSize(width: 40, height: 40)
        let selectedColor = UIColor(red: 0.53, green: 0.81, blue: 0.92, alpha: 1.00)
        
        let vc1 = MainViewController()
        let vc2 = SecondMainViewController()
        
        if let resizedHouseImage = UIImage(named: "house.png")?.resizeImage(targetSize: targetSize) {
            vc1.tabBarItem.image = resizedHouseImage.withRenderingMode(.alwaysOriginal)
        }
        
        if let resizedChatImage = UIImage(named: "chat.png")?.resizeImage(targetSize: targetSize) {
            vc2.tabBarItem.image = resizedChatImage.withRenderingMode(.alwaysOriginal)
        }
        
        let leftEmptyVc = UIViewController()
        let rightEmptyVc = UIViewController()
        [leftEmptyVc, rightEmptyVc].forEach{ $0.tabBarItem.isEnabled = false }
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
        
        
        viewControllers = [leftEmptyVc, vc1, vc2, rightEmptyVc]
        self.selectedIndex = 1
    }
    
    ///MARK: 애니메이션 기능
    private func animateTabBarItem(at index: Int){
        guard let tabBarItems = tabBar.items,
              index < tabBarItems.count,
              let imageView = tabBar.subviews[index + 1].subviews.first(where: { $0 is UIImageView}) as? UIImageView else{
            return
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            imageView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                imageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            }, completion: nil)
        }
    }
    
    
    private func colorBar(at index: Int){
        switch index{
    case 1:
        layer.fillColor = UIColor(red: 0.50, green: 0.91, blue: 1.00, alpha: 1.00).cgColor
    case 2:
        layer.fillColor = UIColor(red: 0.18, green: 0.87, blue: 0.59, alpha: 1.00).cgColor
        default:
            layer.fillColor = UIColor.white.cgColor
        }
    }
    
    //MARK: - Tab Function
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let index = viewControllers?.firstIndex(of: viewController) else{
            return true
        }
        selectMenu("TapSound", "wav")
        colorBar(at: index)
        animateTabBarItem(at: index)
        
        
        return true
    }
}
