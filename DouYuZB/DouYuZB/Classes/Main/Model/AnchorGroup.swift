//
//  Anchor.swift
//  DouYuZB
//
//  Created by huarong on 2018/3/25.
//  Copyright © 2018年 huarong. All rights reserved.
//

//明明有tag_name、icon_name 属性，依然会走 override func setValue(_ value: Any?, forUndefinedKey key: String)

//原因
//在swift3中，编译器自动推断@objc，换句话说，它自动添加@objc
//在swift4中，编译器不再自动推断，你必须显式添加@objc
//
//还有一种更简单的方法，不必一个一个属性的添加,在类名前面加@objcMembers

import UIKit

@objcMembers class AnchorGroup: BaseGameModel {
    //该组中对应的房间信息
    var room_list: [[String : Any]]? {
        //属性监听器
        didSet {
            guard let room_list = room_list else {return}
            for dic in room_list {
                anchors.append(AnchorModel(dic: dic))
            }

        }
    }
    //该组中显示的图标
    var icon_name: String = "home_header_normal"

    //定义主播的模型对象数组
    lazy var anchors: [AnchorModel] = [AnchorModel]()
    
    
//    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "room_list" {
//            if let dataArry = value as? [[String:NSObject]] {
//                for dic in dataArry {
//                    anchors.append(AnchorModel(dic: dic))
//                }
//            }
//        }
//    }
 
}
