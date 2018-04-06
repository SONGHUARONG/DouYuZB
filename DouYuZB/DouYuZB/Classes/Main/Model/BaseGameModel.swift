//
//  BaseGameModel.swift
//  DouYuZB
//
//  Created by huarong on 2018/4/1.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit

@objcMembers class BaseGameModel: NSObject {
    var tag_name: String = ""
    var icon_url: String = ""
    
    override init() {
        
    }
    
    init(dic : [String : Any]) {
        super.init()
        
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
}
