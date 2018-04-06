//
//  AnchorModel.swift
//  DouYuZB
//
//  Created by huarong on 2018/3/25.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit

@objcMembers class AnchorModel: NSObject {
    //房间号
    var room_id: Int = 0
    //房间图片对应url
    var vertical_src: String = ""
    //判断是电脑直播还是手机直播
    //0:电脑直播  1:手机直播
    var isVertical: Int = 0
    //房间名称
    var room_name: String = ""
    //主播昵称
    var nickname: String = ""
    //在线人数
    var online: Int = 0
    //所在城市
    var anchor_city: String = ""
    
    init(dic: [String : Any]) {
        super.init()
        
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
}
