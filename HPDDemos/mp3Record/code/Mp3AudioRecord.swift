//
//  Mp3AudioRecord.swift
//  HPDDemos
//
//  Created by huangpeidong on 2018/11/4.
//  Copyright © 2018年 hpd. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation
import Toaster

class Mp3AudioRecord: NSObject {
    
    //1
    
    static let shared = Mp3AudioRecord()
    
    private let cafPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/Recording.caf"
    private let mp3Path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/Recording.mp3"
    
    private var audioRecrod: AVAudioRecorder?
    private var timer:Timer?

    var audioRecordProtocol:HPDAudioRecordProtocol?
    
    private override init() {
        super.init()
        do {
            // 录音会话设置
            let audioSession = AVAudioSession.sharedInstance()
            // 设置类别,表示该应用同时支持播放和录音
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            // 启动音频会话管理,此时会阻断后台音乐的播放.
            try audioSession.setActive(true)
            
            // 录音设置
            var settings: [String: Any] = [:]
            settings[AVFormatIDKey] = NSNumber(value: kAudioFormatLinearPCM) // 设置录音格式，不支持MP3
            settings[AVSampleRateKey] = NSNumber(value: 44100) // 设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
            settings[AVNumberOfChannelsKey] = NSNumber(value: 2) // 录音通道数
            settings[AVLinearPCMBitDepthKey] = NSNumber(value: 16) // 线性采样位数，one of 8, 16, 24, or 32.
            settings[AVEncoderAudioQualityKey] = NSNumber(value: AVAudioQuality.min.rawValue) // 质量
            audioRecrod = try AVAudioRecorder(url: URL(string: cafPath)!, settings: settings)
            audioRecrod?.delegate = self
    
        }catch {
            print("录音器初始化失败")
        }
    }
    
    func start() {
        
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first)
        do {
            if FileManager.default.fileExists(atPath: cafPath) {
                try FileManager.default.removeItem(atPath: cafPath)
            }
            audioRecrod?.prepareToRecord()
            audioRecrod?.record()
            audioRecordProtocol?.audioRecordStart()
            releaseTimer()
            timer = Timer.init(timeInterval: 1, repeats: true) { [weak self](timer) in
                print(self?.audioRecrod?.currentTime)
                self?.audioRecordProtocol?.audioRecordProgress(progress: self?.audioRecrod?.currentTime ?? 0)
            }
            RunLoop.main.add(timer!, forMode: .commonModes)
            print("录音器开始录音")
        }catch {
            print("start失败")
        }
    }
    
    func finish() {
        print("录音器结束录音")
        audioRecrod?.stop()
    }
    
    func releaseTimer() {
        timer?.invalidate()
        timer = nil
    }
}

extension Mp3AudioRecord: AVAudioRecorderDelegate {
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        print("audioRecorderEncodeErrorDidOccur")
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            print("audioRecorderDidFinishRecording")
            releaseTimer()
            audioRecordProtocol?.audioRecordFinish()
        }
    }
}
