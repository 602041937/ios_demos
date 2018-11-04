//
//  BanWordsEntity.swift
//  HPDDemos
//
//  Created by hpd on 2018/9/12.
//  Copyright © 2018年 hpd. All rights reserved.
//

import ObjectMapper

class BanWordsEntity: Mappable {
    
    var words: [String]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        words <- map["words"]
    }
}
