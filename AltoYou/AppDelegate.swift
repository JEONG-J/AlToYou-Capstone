//
//  AppDelegate.swift
//  AltoYou
//
//  Created by 정의찬 on 10/3/23.
//

import UIKit
import SwiftUI
import AVFoundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var backgroundMusicPlayer: AVAudioPlayer?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        
        let animationViewController = SplashViewController()
        animationViewController.appDelegate = self
         
        window.rootViewController = animationViewController
        startMusic()
        window.makeKeyAndVisible()
        
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
    
    ///MARK: - 배경화면 음악 재생 함수
    private func startMusic(){
        if let bundle = Bundle.main.path(forResource: "BackgroundMusic", ofType: "mp3"){
            let backgroundMusicUrl = URL(fileURLWithPath: bundle)
            
            do{
                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: backgroundMusicUrl)
                guard let backgroundMusicPlayer = backgroundMusicPlayer else { return }
                backgroundMusicPlayer.numberOfLoops = -1
                backgroundMusicPlayer.volume = 0.3
                
                backgroundMusicPlayer.prepareToPlay()
                backgroundMusicPlayer.play()
            } catch{
                fatalError()
            }
        }
    }
}
