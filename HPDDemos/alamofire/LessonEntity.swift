//
//  LessonEntity.swift
//  HPDDemos
//
//  Created by hpd on 2018/9/12.
//  Copyright © 2018年 hpd. All rights reserved.
//

import ObjectMapper

class LessonEntity: Mappable {
    
    var date:String?
    var content:[LessonEntityContentItem]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        date <- map["date"]
        content <- map["content"]
    }
}

class LessonEntityContentItem: Mappable {
    
    var teacherName:String?
    var shortLessonTitle:String?
    var memo:String?
    var time:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        teacherName <- map["teacher_name"]
        shortLessonTitle <- map["short_lesson_title"]
        memo <- map["memo"]
        time <- map["time"]
    }
}
