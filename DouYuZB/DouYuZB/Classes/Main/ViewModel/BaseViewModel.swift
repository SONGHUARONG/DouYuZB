
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
    func loadAnchorData(URLString: String, parameters: [String : Any]? = nil, finishedCallback: @escaping () -> ()){
        NetworkTools.requestData(.get, URLString: URLString,parameters: parameters) { (result) in
            guard let resultDic = result as? [String : Any] else {return}
            guard let dicArray = resultDic["data"] as? [[String : Any]] else {return}
            for dic in dicArray {
                self.anchorGroups.append(AnchorGroup(dic: dic))
            }
            finishedCallback()
        }
    }
}
