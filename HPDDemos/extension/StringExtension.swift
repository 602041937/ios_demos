//
//  StringExtension.swift
//  HPDDemos
//
//  Created by hpd on 2018/9/18.
//  Copyright © 2018年 hpd. All rights reserved.
//

import UIKit

// MARK: - 计算text宽高
extension String {
    typealias AttributedDict = [NSAttributedStringKey: Any]
    
    /// 根据给出的宽度，计算高度
    func heightWith(constraintedWidth: CGFloat, attributes: AttributedDict?) -> CGFloat {
        let textStr = self as NSString
        let constraintedSize = CGSize(width: constraintedWidth, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = textStr.boundingRect(with: constraintedSize, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
        return CGFloat(ceilf(Float(boundingBox.height)))
    }
    
    /// 根据给出的高度和属性，计算宽度
    func widthWith(constraintedHeight: CGFloat, attributes: AttributedDict?) -> CGFloat {
        let textStr = self as NSString
        let constraintedSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: constraintedHeight)
        let boundingBox = textStr.boundingRect(with: constraintedSize, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
        return CGFloat(ceilf(Float(boundingBox.width)))
    }
}
