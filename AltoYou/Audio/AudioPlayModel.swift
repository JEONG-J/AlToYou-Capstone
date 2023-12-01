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
public var backgroundMusicPlayer: AVAudioPlayer?
private var characterRequest: AVPlayer?
private var originalVolume: Float = 0.2


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

public func selectMenu(_ fileName: String, _ fileType: String) {
    let soundKey = "\(fileName).\(fileType)"
    
    if let soundEffectPlayer = soundEffectPlayers[soundKey] {
        playSoundEffect(soundEffectPlayer)
    } else if let bundle = Bundle.main.path(forResource: fileName, ofType: fileType) {
        let soundEffectUrl = URL(fileURLWithPath: bundle)

        do {
            let newSoundEffectPlayer = try AVAudioPlayer(contentsOf: soundEffectUrl)
            soundEffectPlayers[soundKey] = newSoundEffectPlayer
            playSoundEffect(newSoundEffectPlayer)
        } catch {
            print("error")
        }
    }
}

private func playSoundEffect(_ player: AVAudioPlayer) {
    player.volume = 0.9
    player.prepareToPlay()
    player.play()
}


public func playVoice(from url: String) {
    guard let characterUrl = URL(string: url) else {
        print("url error")
        return
    }

    do {
        print("file URL : \(characterUrl)")
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        
        let playerItem = AVPlayerItem(url: characterUrl)
        characterRequest = AVPlayer(playerItem: playerItem)
        characterRequest?.volume = 1.0  // AVPlayer의 볼륨 범위는 0.0에서 1.0입니다.
        characterRequest?.play()
    } catch {
        print("오디오 파일 재생에 실패했습니다: \(error)")
    }
}
