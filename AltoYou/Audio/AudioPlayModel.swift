//
//  AudioPlayModel.swift
//  AltoYou
//
//  Created by 정의찬 on 11/12/23.
//

import Foundation
import UIKit
import AVFoundation

private var soundEffectPlayer: AVAudioPlayer?
private var backgroundMusicPlayer: AVAudioPlayer?
private var originalVolume: Float = 0.4

public func startMusic(_ fileName: String? = nil){
    if let bundle = Bundle.main.path(forResource: fileName, ofType: "mp3"){
        let backgroundMusicUrl = URL(fileURLWithPath: bundle)
        
        do{
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: backgroundMusicUrl)
            guard let backgroundMusicPlayer = backgroundMusicPlayer else { return }
            backgroundMusicPlayer.numberOfLoops = -1
            backgroundMusicPlayer.volume = originalVolume
            
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.play()
        } catch{
            fatalError()
        }
    }
}

public func playSoundEffect(_ fileName: String) {
    if let bundle = Bundle.main.path(forResource: fileName, ofType: "mp3") {
        let soundEffectUrl = URL(fileURLWithPath: bundle)

        do {
            soundEffectPlayer = try AVAudioPlayer(contentsOf: soundEffectUrl)
            guard let soundEffectPlayer = soundEffectPlayer else { return }

            backgroundMusicPlayer?.volume = 0.1
            soundEffectPlayer.volume = 0.6
            soundEffectPlayer.prepareToPlay()
            soundEffectPlayer.play()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + soundEffectPlayer.duration){
                backgroundMusicPlayer?.volume = originalVolume
            }
        } catch {
            fatalError("Failed to initialize the sound effect player")
        }
    }
}

