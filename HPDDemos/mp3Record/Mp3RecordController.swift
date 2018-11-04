//
//  Mp3RecordController.swift
//  HPDDemos
//
//  Created by huangpeidong on 2018/11/4.
//  Copyright © 2018年 hpd. All rights reserved.
//

import UIKit


class Mp3RecordController: UIViewController {
    
    static func newInstance() -> Mp3RecordController{
        return UIStoryboard(name: "Mp3Record", bundle: nil).instantiateViewController(withIdentifier: "Mp3RecordController") as! Mp3RecordController
    }
    
    @IBAction func startRecordClick(_ sender: Any) {
        Mp3AudioRecord.shared.start()
    }
    
    @IBAction func finishRecordClick(_ sender: Any) {
        Mp3AudioRecord.shared.finish()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
