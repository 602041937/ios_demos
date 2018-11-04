//
//  RoomCommentResponse.swift
//  HPDDemos
//
//  Created by hpd on 2018/9/12.
//  Copyright © 2018年 hpd. All rights reserved.
//

import ObjectMapper

class RoomCommentResponse: Mappable {
    
    var url:String?
    var content:String?
    var name:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        url <- map["url"]
        content <- map["content"]
        name <- map["name"]
    }
}
