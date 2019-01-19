//
//  HPDAudioPlayer.swift
//  HPDDemos
//
//  Created by huangpeidong on 2018/12/11.
//  Copyright © 2018年 hpd. All rights reserved.
//

import UIKit
import AVFoundation

class HPDAudioPlayer: NSObject {
    
    static let shared = HPDAudioPlayer()
    
    var audioPlayer: AVAudioPlayer!
    
    var audioPlayerProtocol:HPDAudioPlayerProtocol?
    
    func setPath(path:String) {
        stop()
        if audioPlayer == nil {
            audioPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer.volume = 1
            audioPlayer.numberOfLoops = 0
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
        }
    }
    
    func play() {
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            audioPlayer.play()
            audioPlayerProtocol?.playerStart()
        }catch{
            audioPlayerProtocol?.playerError()
        }
    }
    
    func pause() {
        if audioPlayer != nil {
            audioPlayer.pause()
        }
        audioPlayerProtocol?.playerPause()
    }
    
    func stop() {
        if audioPlayer != nil {
            audioPlayer.stop()
        }
        audioPlayerProtocol?.playerStop()
    }
}

extension HPDAudioPlayer: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        audioPlayerProtocol?.playerStop()
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        audioPlayerProtocol?.playerError()
    }
}
