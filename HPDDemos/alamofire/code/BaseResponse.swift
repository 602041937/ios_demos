//
//  BaseResponse.swift
//  HPDDemos
//
//  Created by hpd on 2018/9/12.
//  Copyright © 2018年 hpd. All rights reserved.
//

import ObjectMapper
import Alamofire

//当content不是一个数组时
class BaseResponse<T: Mappable>: Mappable {
    
    var status:Int?
    var content:T?
    var message:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        content <- map["content"]
        message <- map["message"]
    }
}



