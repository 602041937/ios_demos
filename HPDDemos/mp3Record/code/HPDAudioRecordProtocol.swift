//
//  HPDAudioRecordProtocol.swift
//  HPDDemos
//
//  Created by huangpeidong on 2018/11/5.
//  Copyright © 2018年 hpd. All rights reserved.
//

import UIKit

protocol HPDAudioRecordProtocol {
    
    func audioRecordStart()
    
    func audioRecordProgress(progress: Double)
    
    func audioRecordFinish()
    
    func audioRecrodError()
}
