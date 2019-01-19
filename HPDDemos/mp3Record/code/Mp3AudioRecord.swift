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

class Mp3AudioRecord: NSObject {
    
    static let shared = Mp3AudioRecord()
    
    let cafPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/Recording.caf"
    private static let mp3Path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/Recording.mp3"
    
    private var audioRecrod: AVAudioRecorder?
    private var timer:Timer?
    private var startTime:Double? = 0
    
    var audioRecordProtocol:HPDAudioRecordProtocol?
    
    func start(mp3Path: String? = mp3Path) {
        
        //请求麦克风权限，刚开始会弹出系统的权限对话框，之后就不会了
        AVAudioSession.sharedInstance().requestRecordPermission { (granted:Bool) in
            if granted {
                self.startRecord()
            } else {
                self.audioRecordProtocol?.audioRecrodError()
            }
        }
    }
    
    private func startRecord() {
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
            settings[AVSampleRateKey] = NSNumber(value: 8000.0) // 设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
            settings[AVNumberOfChannelsKey] = NSNumber(value: 2) // 录音通道数
            settings[AVLinearPCMBitDepthKey] = NSNumber(value: 16) // 线性采样位数，one of 8, 16, 24, or 32.
            settings[AVEncoderAudioQualityKey] = NSNumber(value: AVAudioQuality.high.rawValue) // 质量
            audioRecrod = try AVAudioRecorder(url: URL(string: cafPath)!, settings: settings)
           
            if FileManager.default.fileExists(atPath: cafPath) {
                try FileManager.default.removeItem(atPath: cafPath)
            }
            
            audioRecrod?.delegate = self
            audioRecrod?.prepareToRecord()
            audioRecrod?.record()
            startTime = audioRecrod?.deviceCurrentTime
            audioRecordProtocol?.audioRecordStart()
            releaseTimer()
            timer = Timer.init(timeInterval: 1, repeats: true) { [weak self](timer) in
                //当录音时，如果使用self?.audioRecrod?.currentTime，插入耳机后获取到的数据会变成负数
                //self?.audioRecordProtocol?.audioRecordProgress(progress: self?.audioRecrod?.currentTime ?? 0)
                if let currentTime = self?.audioRecrod?.deviceCurrentTime,let startTime = self?.startTime {
                    self?.audioRecordProtocol?.audioRecordProgress(progress: currentTime - startTime)
                }
            }
            RunLoop.main.add(timer!, forMode: .commonModes)
            print("录音器开始录音")
        }catch {
            print("start失败")
            releaseTimer()
            audioRecordProtocol?.audioRecrodError()
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
        releaseTimer()
        audioRecordProtocol?.audioRecrodError()
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        releaseTimer()
        if flag {
            print("audioRecorderDidFinishRecording")
            var filePath:String?
            if let info = TransformMP3.transformCAF(toMP3: Mp3AudioRecord.shared.cafPath) as? [String:String] {
                filePath = info["filePath"]
            }
            audioRecordProtocol?.audioRecordFinish(mp3Path:filePath)
        }else {
            audioRecordProtocol?.audioRecrodError()
        }
    }
}
