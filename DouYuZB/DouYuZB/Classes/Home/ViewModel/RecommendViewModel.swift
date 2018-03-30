//
//  RecommendViewModel.swift
//  DouYuZB
//
//  Created by huarong on 2018/3/24.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit
import Alamofire

class RecommendViewModel {
    //懒加载属性
    lazy var cycleModels: [CycleModel] = [CycleModel]()
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    private lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    private lazy var prettyGroup: AnchorGroup = AnchorGroup()
}

//MARK:发送网络请求
extension RecommendViewModel {
    //请求无线轮播数据
    func requestCycleData(finishCallBack: @escaping () -> ()){
        let parameters = ["version" : "2.300"]
        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: parameters) { (result) in
//            print(result)
            //由于数据访问不了，写死json数据
            guard let resultDic = result as? [String : NSObject] else {return}
            guard let dataArry = resultDic["data"] as? [[String : NSObject]] else {return}
            for dic in dataArry {
                self.cycleModels.append(CycleModel(dic: dic))
            }
            
            finishCallBack()
        }
    }
    
    
    //请求推荐数据
    func requestData(finishCallBack: @escaping () -> ()){
        //1.定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]
        
        //2.创建group
        let dispatchGroup = DispatchGroup()
        
        //3.请求第0组的推荐数据
        dispatchGroup.enter()
        
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime()]) { (result) in
//            print(result)
            //1.将result转换成字典类型
            guard let resultDic = result as? [String : NSObject] else {return}
            //2.根据data该key，获取数据
            guard let dataArry = resultDic["data"] as? [[String : NSObject]] else{return}
            //3.遍历数组，并将字典转换成模型对象(KVC)
            //3.1设置group属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            //3.2获取热门数据
            for dic in dataArry {
                let anchor = AnchorModel(dic: dic)
                self.bigDataGroup.anchors.append(anchor)
            }
//            for (index,dic) in dataArry.enumerated() {
//                let anchor = AnchorModel(dic: dic)
//                self.bigDataGroup.anchors.append(anchor)
//                print("第0组item\(index) :\(anchor.vertical_src)")
//            }

            //3.3离开组
            dispatchGroup.leave()
        }
        
        //4.请求第1组的颜值数据
        dispatchGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
//            print(result)
            //1.将result转换成字典类型
            guard let resultDic = result as? [String : NSObject] else {return}
            //2.根据data该key，获取数据
            guard let dataArry = resultDic["data"] as? [[String : NSObject]] else{return}
            //3.遍历数组，并将字典转换成模型对象(KVC)
            //3.1设置group属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            //3.2获取主播数据
            for dic in dataArry {
                let anchor = AnchorModel(dic: dic)
                self.prettyGroup.anchors.append(anchor)
            }
            //3.3离开组
            dispatchGroup.leave()
        }
        
        //5.请求第2-12组的游戏数据
        dispatchGroup.enter()
        //https://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1521988663
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
//            print(NSDate.getCurrentTime())
//            print(result)
            
            //1.将result转换成字典类型
            guard let resultDic = result as? [String : NSObject] else {return}
            //2.根据data该key，获取数据
            guard let dataArry = resultDic["data"] as? [[String : NSObject]] else{return}
            //3.遍历数组，获取字典，并将字典转换成模型对象(KVC)
            for dic in dataArry {
                let group = AnchorGroup(dict: dic)
                self.anchorGroups.append(group)
            }
//            for group in self.anchorGroups {
//                for anchor in group.anchors{
////                    print(anchor.nickname)
//                }
////                print("----------------")
//            }
            //4.离开组
            dispatchGroup.leave()
        }
        
        //6.所有的数据都请求到，再进行排序
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallBack()
        }
        
    }
}
