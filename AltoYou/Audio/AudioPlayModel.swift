//
//  AudioPlayModel.swift
//  AltoYou
//
//  Created by 정의찬 on 11/12/23.
//

import Foundation
import UIKit
import AVFoundation


private var soundEffectPlayers: [String: AVAudioPlayer] = [:]
private var soundEffectPlayer: AVAudioPlayer?
private var characterRequest: AVPlayer?
private var originalVolume: Float = 0.3

public var backgroundMusicPlayer: AVAudioPlayer?


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

public func playSoundEffect(_ fileName: String, _ volume: Float) {
    if let bundle = Bundle.main.path(forResource: fileName, ofType: "mp3") {
        let soundEffectUrl = URL(fileURLWithPath: bundle)
        print(soundEffectUrl)
        
        do {
            soundEffectPlayer = try AVAudioPlayer(contentsOf: soundEffectUrl)
            guard let soundEffectPlayer = soundEffectPlayer else { return }
            
            backgroundMusicPlayer?.volume = 0.1
            soundEffectPlayer.volume = volume
            soundEffectPlayer.prepareToPlay()
            soundEffectPlayer.play()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + soundEffectPlayer.duration){
                backgroundMusicPlayer?.volume = originalVolume
            }
        } catch {
            print("Failed to initialize the sound effect player")
        }
    }
}


private func selectHistoryInit(_ fileName: String, _ fileType: String) {
    let soundKey = "\(fileName).\(fileType)"
    
    if soundEffectPlayers[soundKey] != nil {
        print("이미 준비 됨 : \(fileName)")
    } else if let bundle = Bundle.main.path(forResource: fileName, ofType: fileType) {
        let soundEffectUrl = URL(fileURLWithPath: bundle)
        
        do {
            let newSoundEffectPlayer = try AVAudioPlayer(contentsOf: soundEffectUrl)
            soundEffectPlayers[soundKey] = newSoundEffectPlayer
            print("준비완료 : \(fileName)")
        } catch {
            print("error")
        }
    }
}

public func selectEffectMusic(_ fileName: String, _ fileType: String) {
    let soundKey = "\(fileName).\(fileType)"
    backgroundMusicPlayer?.volume = 0.1
    soundEffectPlayers[soundKey]?.volume = 0.9
    soundEffectPlayers[soundKey]?.prepareToPlay()
    soundEffectPlayers[soundKey]?.play()
    DispatchQueue.main.asyncAfter(deadline: .now() + (soundEffectPlayers[soundKey]?.duration ?? 0)){
        backgroundMusicPlayer?.volume = originalVolume
    }
}

func prepareAudioPlayer() {
    characterRequest = AVPlayer()
    characterRequest?.volume = 1.0
    
    DispatchQueue.global(qos: .background).async {
        do{
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio error")
        }
    }
}


func playVoice(from url: String) {
    guard let characterUrl = URL(string: url) else {
        print("url error")
        return
    }
    
    DispatchQueue.main.async {
        let playerItem = AVPlayerItem(url: characterUrl)
        characterRequest?.replaceCurrentItem(with: playerItem)
        characterRequest?.play()
    }
}

public func prepareEffectMusic(){
    selectHistoryInit("startSound", "wav")
    
    DispatchQueue.global(qos: .userInitiated).async {
        selectHistoryInit("outSound", "wav")
        selectHistoryInit("deleteSound", "wav")
        selectHistoryInit("backgroundMusic", "mp3")
        selectHistoryInit("selectCharacter", "wav")
        selectHistoryInit("cellButton", "wav")
        selectHistoryInit("Mongmong-e", "mp3")
        selectHistoryInit("propeller", "mp3")
        selectHistoryInit("Hindung-e", "mp3")
        selectHistoryInit("Yangyangi", "mp3")
        selectHistoryInit("randomText", "wav")
        selectHistoryInit("TapSound", "wav")
        selectHistoryInit("micButton", "wav")
    }
}
