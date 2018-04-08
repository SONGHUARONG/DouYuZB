//
//  FunnyViewModel.swift
//  DouYuZB
//
//  Created by huarong on 2018/4/7.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseViewModel {

}

extension FunnyViewModel {
    func loadFunnyData(finishedCallback: @escaping () -> ()) {
        
        loadAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/2", parameters:  ["limit" : 30, "offset" : 0], finishedCallback: finishedCallback)
        
    }
}
