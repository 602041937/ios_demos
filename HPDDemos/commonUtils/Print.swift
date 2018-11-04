//
//  Print.swift
//  HPDDemos
//
//  Created by hpd on 2018/9/11.
//  Copyright © 2018年 hpd. All rights reserved.
//

import UIKit

//打印对象内存地址
func printAddress(values:AnyObject...){
    for value in values {
        print(type(of: value))
        print(Unmanaged.passUnretained(value).toOpaque())
        print("-----------------------------------------")
    }
}
