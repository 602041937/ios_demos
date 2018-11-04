//
//  AppStatusCodeError.swift
//  HPDDemos
//
//  Created by hpd on 2018/9/18.
//  Copyright © 2018年 hpd. All rights reserved.
//

class AppStatusCodeError {

    static func dealStatusCode(code:Int?,message:String?) {
        print("status不为0")
        switch code {
        case 103:
            print("用户无效")
        case 104:
            print("token 过期")
        default:
            if let message = message {
                print(message)
            }
        }
    }
}
