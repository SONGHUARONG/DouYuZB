//
//  CycleModel.swift
//  DouYuZB
//
//  Created by huarong on 2018/3/28.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit

@objcMembers class CycleModel: NSObject {
    //标题
    var title: String = ""
    //展示的图片地址
    var pic_url: String = ""
    //主播信息对应的字典
    var room: [String : Any]? {
        didSet {
            guard let room = room else {
                return
            }
            anchor = AnchorModel(dic: room)
        }
    }
    //主播信息对应的模型
    var anchor: AnchorModel?
    
    init(dic: [String : Any]) {
        super.init()
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
