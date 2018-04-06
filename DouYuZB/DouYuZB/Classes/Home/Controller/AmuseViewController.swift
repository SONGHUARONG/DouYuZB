//
//  AmuseViewController.swift
//  DouYuZB
//
//  Created by huarong on 2018/4/6.
//  Copyright © 2018年 huarong. All rights reserved.
//

import UIKit

private let kMenuViewH: CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    
    fileprivate lazy var amuseVM: AmuseViewModel = AmuseViewModel()
    fileprivate lazy var amuseMenuView: AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
    }()
}

//MARK:设置ui界面
extension AmuseViewController {
    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(amuseMenuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}


//MARK:请求娱乐数据
extension AmuseViewController {
    override func loadData(){
        //1.给父类ViewModel赋值
        baseVM = amuseVM
        //2.请求数据
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
            //去除“最热”组
            var tempArry = self.amuseVM.anchorGroups
            tempArry.removeFirst()
            self.amuseMenuView.groups = tempArry
        }
    }
}




