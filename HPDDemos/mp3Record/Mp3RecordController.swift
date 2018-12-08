//
//  Mp3RecordController.swift
//  HPDDemos
//
//  Created by huangpeidong on 2018/11/4.
//  Copyright © 2018年 hpd. All rights reserved.
//

import UIKit


class Mp3RecordController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    static func newInstance() -> Mp3RecordController{
        return UIStoryboard(name: "Mp3Record", bundle: nil).instantiateViewController(withIdentifier: "Mp3RecordController") as! Mp3RecordController
    }
    
    @IBAction func startRecordClick(_ sender: Any) {
        
        Mp3AudioRecord.shared.audioRecordProtocol = self
        Mp3AudioRecord.shared.start()
    }
    
    @IBAction func finishRecordClick(_ sender: Any) {
        Mp3AudioRecord.shared.finish()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension Mp3RecordController:HPDAudioRecordProtocol {
    
    func audioRecrodError() {
        print("audioRecrodError")
        label.text = "录音错误"
    }
    
    func audioRecordStart() {
        print("audioRecordStart")
        label.text = "录音开始"
    }
    
    func audioRecordProgress(progress: Double) {
        print("audioRecordProgress")
        label.text = "录音进度\(progress)"
    }
    
    func audioRecordFinish() {
        print("audioRecordFinish")
        label.text = "录音结束"
    }
}
