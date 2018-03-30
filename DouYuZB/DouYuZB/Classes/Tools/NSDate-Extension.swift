//
//  NSDate-Extension.swift
//  DouYuZB
//
//  Created by huarong on 2018/3/25.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }

}
