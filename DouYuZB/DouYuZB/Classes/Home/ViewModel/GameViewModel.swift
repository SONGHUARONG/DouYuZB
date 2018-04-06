//
//  GameViewModel.swift
//  DouYuZB
//
//  Created by huarong on 2018/4/1.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit

class GameViewModel {
    lazy var gameModels: [GameModel] = [GameModel]()
}

extension GameViewModel {
    func loadAllGameData(finishCallBack: @escaping () -> ()){
//        let parameters = ["shortName" : "game"]
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: nil) { (result) in
            guard let resultDic = result as? [String : Any] else {return}
            guard let dataArry = resultDic["data"] as? [[String : Any]] else {return}
            
            for dic in dataArry {
                self.gameModels.append(GameModel(dic: dic))
            }
            
            finishCallBack()
        }
    }
}
