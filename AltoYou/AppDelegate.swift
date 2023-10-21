//
//  AppDelegate.swift
//  AltoYou
//
//  Created by 정의찬 on 10/3/23.
//

import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        //Splash
        let launchViewController = UIViewController()
        let splashImg = UIImage(named: "splash.png")
        let backImg = UIImageView(frame: launchViewController.view.bounds)
        backImg.image = splashImg
        backImg.contentMode = .scaleAspectFill
        launchViewController.view.addSubview(backImg)
        window.rootViewController = launchViewController
        window.makeKeyAndVisible()
        
        //MainTabBarTransition
        let mainTabBarController = MainTabBarController()
        mainTabBarController.view.frame = window.bounds
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            UIView.animate(withDuration: 0.3, animations: {
                launchViewController.view.alpha = 0
            }, completion: { _ in
                self.window?.rootViewController = mainTabBarController
                self.window?.makeKeyAndVisible()
            })
        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscapeRight
    }
    
    
}

