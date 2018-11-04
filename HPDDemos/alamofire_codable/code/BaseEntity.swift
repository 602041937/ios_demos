//
//  BaseEntity.swift
//  HPDDemos
//
//  Created by hpd on 2018/9/19.
//  Copyright © 2018年 hpd. All rights reserved.
//

import UIKit

class BaseEntity<T:Codable> : Codable {

    var status:Int?
    var content:T?
    var message:String?
}
