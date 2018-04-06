//
//  AmuseViewModel.swift
//  DouYuZB
//
//  Created by huarong on 2018/4/6.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit

class AmuseViewModel: BaseViewModel {
    
}

//MARK:请求娱乐数据
extension AmuseViewModel {//"http://capi.douyucdn.cn/api/v1/getHotRoom/2"
    func loadAmuseData(finishedCallback: @escaping () -> ()){
            loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
        }
    }

