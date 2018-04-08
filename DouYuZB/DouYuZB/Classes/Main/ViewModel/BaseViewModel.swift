
//
//  BaseViewModel.swift
//  DouYuZB
//
//  Created by huarong on 2018/4/6.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel {
    func loadAnchorData(isGroupData: Bool, URLString: String, parameters: [String : Any]? = nil, finishedCallback: @escaping () -> ()){
        NetworkTools.requestData(.get, URLString: URLString,parameters: parameters) { (result) in
            //1.取出对应数据并转成字典
            guard let resultDic = result as? [String : Any] else {return}
            guard let dataArray = resultDic["data"] as? [[String : Any]] else {return}
            //2.判断是否分组&字典转模型
            if isGroupData {
                //2.1遍历数组中的字典
                for dic in dataArray {
                    self.anchorGroups.append(AnchorGroup(dic: dic))
                }
            }else{
                //2.1创建组
                let group = AnchorGroup()
                //2.2遍历dataArray中所有字典
                for dic in dataArray {
                    group.anchors.append(AnchorModel(dic: dic))
                }
                //2.3将group加入到anchorGroups
                self.anchorGroups.append(group)
            }
            
            //3.完成回调
            finishedCallback()
        }
    }
}
